


import 'package:uchat/app/constants/firebase_collection.dart';
import 'package:uchat/user/data/data_sources/remote/user_remote_data_sources.dart';
import 'package:uchat/user/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {

  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;

  UserRemoteDataSourceImpl({required this.fireStore, required this.auth});

  String _verificationId = "";


  @override
  Future<void> createUser(UserModel user) async {

    final userCollection =
    fireStore.collection(FirebaseCollectionManager.users);

    final uid = await getCurrentUID();

    final newUser = UserModel(
      uid: uid,
      name: user.name,
      phoneNumber: user.phoneNumber,
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
    ).toDocument();


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
  Stream<List<UserModel>> getSingleUser(String uid) {
    final userCollection =
    fireStore.collection(FirebaseCollectionManager.users).where("uid", isEqualTo: uid);
    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) async {

    try {

      final AuthCredential credential = PhoneAuthProvider.credential(
          smsCode: smsPinCode, verificationId: _verificationId);

      await auth.signInWithCredential(credential);


    } on FirebaseAuthException catch(e) {
      if(e.code == 'invalid-verification-code') {
        // toast("Invalid Verification Code");
      } else if (e.code == 'quota-exceeded') {
        // toast("SMS quota-exceeded");
      }
    } catch (e) {
      // toast("Unknown exception please try again");
    }
  }

  @override
  Future<void> signOut() async => auth.signOut();

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

    phoneVerificationCompleted(PhoneAuthCredential authCredential) async {
      print("phone verified : Token ${authCredential.token} ${authCredential.signInMethod}");

      await auth.signInWithCredential(authCredential).then((value) async {
        print("User : ${value.user!.uid}");
      });
    }

    phoneVerificationFailed(FirebaseAuthException firebaseAuthException) {
      print(
        "phone failed : ${firebaseAuthException.message},${firebaseAuthException.code}",
      );
    }

    phoneCodeAutoRetrievalTimeout(String verificationId) {
      _verificationId = verificationId;
      print("time out :$verificationId");
    }

    phoneCodeSent(String verificationId, int? forceResendingToken) {
      _verificationId = verificationId;
    }

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: phoneVerificationCompleted,
      verificationFailed: phoneVerificationFailed,
      timeout: const Duration(seconds: 60),
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
    );
  }

}