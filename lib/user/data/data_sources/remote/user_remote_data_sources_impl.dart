


import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uchat/app/constants/firebase_collection.dart';
import 'package:uchat/app/constants/store.dart';
import 'package:uchat/user/data/data_sources/remote/user_remote_data_sources.dart';
import 'package:uchat/user/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {

  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  UserRemoteDataSourceImpl({required this.fireStore, required this.auth,required this.storage});



  @override
  Future<void> createUser(UserModel user) async {

    final userCollection =
    fireStore.collection(FirebaseCollectionManager.users);

    final uid = await getCurrentUID();

    final newUser = UserModel(
      uid: uid,
      name: user.name,
      email: user.email,
      image: user.image,
      token: user.token,
      aboutMe: user.aboutMe,
      status: user.status,
      lastSeen: user.lastSeen,
      createdAt: user.createdAt,
      isOnline: user.isOnline,
      friendsUIDs: user.friendsUIDs,
      getFriendRequestsUIDs: user.getFriendRequestsUIDs,
      sentFriendRequestsUIDs: user.sentFriendRequestsUIDs,
    ).toMap();


    try {

      userCollection.doc(uid).get().then((userDoc) {


        if(!userDoc.exists) {
          userCollection.doc(uid).set(newUser);
        } else {
          userCollection.doc(uid).update(newUser);
        }
      });

    } catch (e) {
      throw Exception("Error occur while creating user");
    }


  }

  @override
  Stream<List<UserModel>> getAllUsers() {
    final userCollection =
    fireStore.collection(FirebaseCollectionManager.users);
    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());

  }

  @override
  Future<String> getCurrentUID() async => auth.currentUser!.uid;



  @override
  Stream<UserModel> getSingleUser(String uid) {
    final documentSnapshot = fireStore.collection(FirebaseCollectionManager.users).doc(uid);
    return documentSnapshot.snapshots().map((event) => UserModel.fromSnapshot(event));
    // return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) async {

    // try {
    //
    //   final AuthCredential credential = PhoneAuthProvider.credential(
    //       smsCode: smsPinCode, verificationId: _verificationId);
    //
    //   await auth.signInWithCredential(credential);
    //
    //
    // } on FirebaseAuthException catch(e) {
    //   if(e.code == 'invalid-verification-code') {
    //     // toast("Invalid Verification Code");
    //   } else if (e.code == 'quota-exceeded') {
    //     // toast("SMS quota-exceeded");
    //   }
    // } catch (e) {
    //   // toast("Unknown exception please try again");
    // }
  }

  @override
  Future<void> signOut() async{
    await auth.signOut();
  }

  @override
  Future<void> updateUser(UserModel user) async {
    final userCollection =
    fireStore.collection(FirebaseCollectionManager.users);

    Map<String, dynamic> userInfo = {};

    // if(user.username != "" && user.username != null) userInfo['username'] = user.username;
    // if(user.status != "" && user.status != null) userInfo['status'] = user.status;
    //
    // if(user.profileUrl != "" && user.profileUrl != null) userInfo['profileUrl'] = user.profileUrl;
    //
    // if(user.isOnline != null) userInfo['isOnline'] = user.isOnline;

    userCollection.doc(user.uid).update(userInfo);



  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async  {
    //
    // phoneVerificationCompleted(PhoneAuthCredential authCredential) async {
    //   print("phone verified : Token ${authCredential.token} ${authCredential.signInMethod}");
    //
    //   await auth.signInWithCredential(authCredential).then((value) async {
    //     print("User : ${value.user!.uid}");
    //   });
    // }
    //
    // phoneVerificationFailed(FirebaseAuthException firebaseAuthException) {
    //   print(
    //     "phone failed : ${firebaseAuthException.message},${firebaseAuthException.code}",
    //   );
    // }
    //
    // phoneCodeAutoRetrievalTimeout(String verificationId) {
    //   _verificationId = verificationId;
    //   print("time out :$verificationId");
    // }
    //
    // phoneCodeSent(String verificationId, int? forceResendingToken) {
    //   _verificationId = verificationId;
    // }
    //
    // await auth.verifyPhoneNumber(
    //   phoneNumber: phoneNumber,
    //   verificationCompleted: phoneVerificationCompleted,
    //   verificationFailed: phoneVerificationFailed,
    //   timeout: const Duration(seconds: 60),
    //   codeSent: phoneCodeSent,
    //   codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
    // );
  }

  @override
  Future<String> logInWithEmailandPassword(String email, String password) async {
    try {
     final c= await auth.signInWithEmailAndPassword(email: email, password: password);
    print("+++++++++++");
     print(c.user!.uid);
     print(c);
     return c.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // toast("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        // toast("Wrong password provided for that user.");
      }
    }
    return "";
  }

  @override
  Future<String> signupWithEmailandPassword(String email, String password) async {
    try {
     final UserCredential= await auth.createUserWithEmailAndPassword(email: email, password: password);
     print("+++++++++++");
     print(UserCredential);
      print(UserCredential.user!.uid);
     return UserCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // toast("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        // toast("The account already exists for that email.");
      }
    } catch (e) {
      // toast("Unknown exception please try again");
    }
    return "";
  }

  @override
  Future<bool> checkUserExists(String emial) async {
    // TODO: implement checkUserExist

   // check if user exists with email
    final userCollection =await fireStore.collection(FirebaseCollectionManager.users).where("email", isEqualTo: emial).get();
    final user = userCollection.docs.first;
    return user.exists;
  }

  @override
  Future<void> saveUserDataToRemote(UserModel user) async {
    await fireStore.collection(FirebaseCollectionManager.users).doc(user.uid).set(user.toMap());
  }

  @override
  Future<UserModel> getUserDataFromRemote(String uid)async {
    DocumentSnapshot userDoc =await  fireStore.collection(FirebaseCollectionManager.users).doc(uid).get() as DocumentSnapshot;
    return UserModel.fromSnapshot(userDoc);
  }

  @override
  Future<String> storeFileToRemote(File file, String uid) async {
    String reference ="${StoreKeyManager.userAvatar}/$uid";
    UploadTask task = storage.ref().child(reference).putFile(file);
    TaskSnapshot snapshot = await task.whenComplete(() => null);
    String downloadUrl= await snapshot.ref.getDownloadURL();
   //copilot kengwo
    return downloadUrl;
  }
}