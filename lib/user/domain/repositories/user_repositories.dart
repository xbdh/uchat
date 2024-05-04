import 'dart:io';

import '../entities/user_entity.dart';

abstract class UserRepository {

  Future<void> verifyPhoneNumber(String phoneNumber);
  Future<void> signInWithPhoneNumber(String smsPinCode);

  // auth
  Future<String> signupWithEmailandPassword(String email, String password);
  Future<String> logInWithEmailandPassword(String email, String password);
  Future<bool> checkUserExists(String email);

  // user
  Future<void> saveUserDataToRemote(UserEntity user);
  Future<UserEntity?> getUserDataFromRemote(String uid);

  Future<void> saveUserDataToLocal(UserEntity user);
  Future<UserEntity?> getUserDataFromLocal();

  Future<String> storeFileToRemote(File file, String uid);

  Future<String> getCurrentUID();

  Future<bool> isSignIn();
  Future<void> signOut();

  Future<void> createUser(UserEntity user);
  Future<void> updateUser(UserEntity user);


  Stream<List<UserEntity>> getAllUsers(bool includeMe);
  Stream<UserEntity> getSingleUser(String uid);


  Future<void> sendFriendRequest(String friendUID, String myUID);
  Future<void> acceptFriendRequest(String friendUID, String myUID);
  Future<void> cancelFriendRequest(String friendUID, String myUID);
  Future<void> removeFriend(String friendUID, String myUID);

  // get friends
  Future<List<UserEntity>> getFriends(String uid);
  // get friend requests
  Future<List<UserEntity>> getFriendRequests(String uid);

  Future<void> setUserOnlineStatus(bool isOnline);

  Future<void> bindFcmToken(String uid, String fcmToken);
  Future<String> getFcmToken(String uid);

}