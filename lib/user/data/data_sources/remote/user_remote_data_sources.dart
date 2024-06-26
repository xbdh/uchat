import 'dart:io';

import 'package:uchat/user/data/models/user_model.dart';

abstract class UserRemoteDataSource {

  Future<void> verifyPhoneNumber(String phoneNumber);
  Future<void> signInWithPhoneNumber(String smsPinCode);

  Future<String> signupWithEmailandPassword(String email, String password);
   Future<String> logInWithEmailandPassword(String email, String password);
   Future<bool> checkUserExists(String email);

  Future<void> saveUserDataToRemote(UserModel user);
  Future<UserModel> getUserDataFromRemote(String uid);
  Future<String> storeFileToRemote(File file, String uid);
  Future<String> getCurrentUID();

  Future<bool> isSignIn();
  Future<void> signOut();

  Future<void> createUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Stream<List<UserModel>> getAllUsers(bool includeMe);
  Stream<UserModel> getSingleUser(String uid);

  Future<void> sendFriendRequest(String friendUID, String myUID);
  Future<void> acceptFriendRequest(String friendUID, String myUID);
  Future<void> cancelFriendRequest(String friendUID, String myUID);
  Future<void> removeFriend(String friendUID, String myUID);

  // get friends
  Future<List<UserModel>> getFriends(String uid);
  // get friend requests
  Future<List<UserModel>> getFriendRequests(String uid);

  Future<void> setUserOnlineStatus(bool isOnline);
  Future<void> bindFcmToken(String uid, String fcmToken);
  Future<String> getFcmToken(String uid);
  // Future<List<ContactEntity>> getDeviceNumber();
}