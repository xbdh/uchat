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
  Stream<List<UserEntity>> getAllUsers();
  Stream<List<UserEntity>> getSingleUser(String uid);

}