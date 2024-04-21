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

  UserRemoteDataSourceImpl(
      {required this.fireStore, required this.auth, required this.storage});

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
      friendRequestsFromUIDs: user.friendRequestsFromUIDs,
      sentFriendRequestsToUIDs: user.sentFriendRequestsToUIDs,
    ).toMap();

    try {
      userCollection.doc(uid).get().then((userDoc) {
        if (!userDoc.exists) {
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
  Stream<List<UserModel>> getAllUsers(bool includeMe) {
    if (includeMe) {
      final userCollection =
          fireStore.collection(FirebaseCollectionManager.users);
      return userCollection.snapshots().map((querySnapshot) =>
          querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
    } else {
      final currentUID = auth.currentUser!.uid;
      final querySnapshot = fireStore
          .collection(FirebaseCollectionManager.users)
          .where("uid", isNotEqualTo: currentUID)
          .snapshots();
      return querySnapshot.map((querySnapshot) =>
          querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
    }
  }

  @override
  Future<String> getCurrentUID() async => auth.currentUser!.uid;

  @override
  Stream<UserModel> getSingleUser(String uid) {
    final documentSnapshot =
        fireStore.collection(FirebaseCollectionManager.users).doc(uid);
    return documentSnapshot
        .snapshots()
        .map((event) => UserModel.fromSnapshot(event));
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
  Future<void> signOut() async {
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
  Future<void> verifyPhoneNumber(String phoneNumber) async {
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
  Future<String> logInWithEmailandPassword(
      String email, String password) async {
    try {
      final c = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      // print("+++++++++++");
      //  print(c.user!.uid);
      //  print(c);
      return c.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // toast("No user found for that email.");
        return "*No user found for that email.*";
      } else if (e.code == 'wrong-password') {
        // toast("Wrong password provided for that user.");
        return "*Wrong password provided for that user.*";
      } else if (e.code == 'invalid-email') {
        return "*The email address is badly formatted.*";
      } else if (e.code == 'unknown') {
        return "*Unknown exception please try again.*";
      }
    } catch (e) {
      return "*Unknown exception please try again*";
      // toast("Unknown exception please try again");
    }
    return "";
  }

  @override
  Future<String> signupWithEmailandPassword(
      String email, String password) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // print("+++++++++++");
      // print(UserCredential);
      //  print(UserCredential.user!.uid);
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "*The password provided is too weak.*";
      } else if (e.code == 'email-already-in-use') {
        return "*The account already exists for that email.*";
      } else if (e.code == 'invalid-email') {
        return "*The email address is badly formatted.*";
      } else if (e.code == 'operation-not-allowed') {
        return "*Email & Password accounts are not enabled*";
      } else if (e.code == 'unknown') {
        return "*Unknown exception please try again*";
        // 7gN3T 2D2tq U0MA0 sgZMw ocDW9 TC3
      }
    } catch (e) {
      return "*Unknown exception please try again*";
      // toast("Unknown exception please try again");
    }
    return "";
  }

  @override
  Future<bool> checkUserExists(String emial) async {
    // TODO: implement checkUserExist

    // check if user exists with email
    final userCollection = await fireStore
        .collection(FirebaseCollectionManager.users)
        .where("email", isEqualTo: emial)
        .get();
    final user = userCollection.docs.first;
    return user.exists;
  }

  @override
  Future<void> saveUserDataToRemote(UserModel user) async {
    await fireStore
        .collection(FirebaseCollectionManager.users)
        .doc(user.uid)
        .set(user.toMap());
  }

  @override
  Future<UserModel> getUserDataFromRemote(String uid) async {
    DocumentSnapshot userDoc = await fireStore
        .collection(FirebaseCollectionManager.users)
        .doc(uid)
        .get() as DocumentSnapshot;
    return UserModel.fromSnapshot(userDoc);
  }

  @override
  Future<String> storeFileToRemote(File file, String uid) async {
    String reference = "${StoreKeyManager.userAvatar}/$uid";
    UploadTask task = storage.ref().child(reference).putFile(file);
    TaskSnapshot snapshot = await task.whenComplete(() => null);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    //copilot kengwo
    return downloadUrl;
  }

  @override
  Future<void> acceptFriendRequest(String friendUID, String myUID) async {
    try {
      final userCollection =
          fireStore.collection(FirebaseCollectionManager.users);
      userCollection.doc(myUID).update({
        "friendRequestsFromUIDs": FieldValue.arrayRemove([friendUID]),
        "friendsUIDs": FieldValue.arrayUnion([friendUID])
      });
      userCollection.doc(friendUID).update({
        "sentFriendRequestsToUIDs": FieldValue.arrayRemove([myUID]),
        "friendsUIDs": FieldValue.arrayUnion([myUID])
      });
    } catch (e) {
      throw Exception("Error occur while accepting friend request");
    }
  }

  @override
  Future<void> cancelFriendRequest(String friendUID, String myUID) async {
    try {
      final userCollection =
          fireStore.collection(FirebaseCollectionManager.users);
      userCollection.doc(myUID).update({
        "sentFriendRequestsToUIDs": FieldValue.arrayRemove([friendUID])
      });
      userCollection.doc(friendUID).update({
        "friendRequestsFromUIDs": FieldValue.arrayRemove([myUID])
      });
    } catch (e) {
      throw Exception("Error occur while canceling friend request");
    }
  }

  @override
  Future<List<UserModel>> getFriendRequests(String uid) async {
    List<UserModel> friendRequests = [];
    try {
      final userCollection =
          fireStore.collection(FirebaseCollectionManager.users);
      final userDoc = await userCollection.doc(uid).get();

      final friendRequestsUIDs = userDoc.get("friendRequestsFromUIDs");
      for (String friendRequestUID in friendRequestsUIDs) {
        final friendRequestDoc =
            await userCollection.doc(friendRequestUID).get();
        friendRequests.add(UserModel.fromSnapshot(friendRequestDoc));
      }
      return friendRequests;
    } catch (e) {
      throw Exception("Error occur while getting friend requests");
    }
  }

  @override
  Future<List<UserModel>> getFriends(String uid) async {
    List<UserModel> friends = [];
    try {
      final userCollection =
          fireStore.collection(FirebaseCollectionManager.users);
      final userDoc = await userCollection.doc(uid).get();

      //print("userDoc+++++= $userDoc");

      final friendsUIDs = userDoc.get("friendsUIDs");
      for (String friendUID in friendsUIDs) {
        final friendDoc = await userCollection.doc(friendUID).get();
        friends.add(UserModel.fromSnapshot(friendDoc));
      }

      //print("friends+++++= $friends");
      return friends;
    } catch (e) {
      throw Exception("Error occur while getting friends");
    }
  }

  @override
  Future<void> removeFriend(String friendUID, String myUID) async {
    try {
      final userCollection =
          fireStore.collection(FirebaseCollectionManager.users);
      userCollection.doc(myUID).update({
        "friendsUIDs": FieldValue.arrayRemove([friendUID])
      });
      userCollection.doc(friendUID).update({
        "friendsUIDs": FieldValue.arrayRemove([myUID])
      });
    } catch (e) {
      throw Exception("Error occur while removing friend");
    }
  }

  @override
  Future<void> sendFriendRequest(String friendUID, String myUID) async {
    try {
      final userCollection =
          fireStore.collection(FirebaseCollectionManager.users);
      userCollection.doc(myUID).update({
        "sentFriendRequestsToUIDs": FieldValue.arrayUnion([friendUID])
      });
      userCollection.doc(friendUID).update({
        "friendRequestsFromUIDs": FieldValue.arrayUnion([myUID])
      });
    } catch (e) {
      throw Exception("Error occur while sending friend request");
    }
  }

  @override
  Future<void> setUserOnlineStatus(bool isOnline) async  {
    final userCollection =
        fireStore.collection(FirebaseCollectionManager.users);
    final uid = auth.currentUser!.uid;
    userCollection.doc(uid).update({"isOnline": isOnline});
  }
}
