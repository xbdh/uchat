
import 'dart:io';

import 'package:uchat/user/data/data_sources/local/user_local_data_sources.dart';
import 'package:uchat/user/data/models/user_model.dart';

import 'package:uchat/user/data/data_sources/remote/user_remote_data_sources.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/domain/repositories/user_repositories.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({required this.remoteDataSource, required this.localDataSource});
  @override
  Future<void> createUser(UserEntity user) async {
    UserModel userModel=UserModel.fromEntity(user);
    remoteDataSource.createUser(userModel);

  }

  @override
  Stream<List<UserEntity>> getAllUsers() {

    Stream<List<UserModel>> userModel=remoteDataSource.getAllUsers();
    Stream<List<UserEntity>> userEntity=userModel.map((event) => event.map((e) => UserEntity.fromUserModel(e)).toList());

    return userEntity;
  }

  @override
  Future<String> getCurrentUID() async => remoteDataSource.getCurrentUID();


  @override
  Stream<UserEntity> getSingleUser(String uid) {
    Stream<UserModel> userModel=remoteDataSource.getSingleUser(uid);
    // convert stream of user model to stream of user entity
    final Stream<UserEntity> userEntity=userModel.map((event) => UserEntity.fromUserModel(event));
    return userEntity;
    // Stream<UserEntity> userEntity=userModel.map((event) => event.map((e) => UserEntity.fromUserModel(e)).toList());
    // return userEntity;
  }
    @override
    Future<bool> isSignIn() async => remoteDataSource.isSignIn();

    @override
    Future<void> signInWithPhoneNumber(String smsPinCode) async => remoteDataSource.signInWithPhoneNumber(smsPinCode);

    @override
    Future<void> signOut() async => remoteDataSource.signOut();

    @override
    Future<void> updateUser(UserEntity user) async {
      UserModel userModel=UserModel.fromEntity(user);
      remoteDataSource.updateUser(userModel);
    }

    @override
    Future<void> verifyPhoneNumber(String phoneNumber) async => remoteDataSource.verifyPhoneNumber(phoneNumber);

  @override
  Future<String> logInWithEmailandPassword(String email, String password) async {
      return remoteDataSource.logInWithEmailandPassword(email, password);
  }

  @override
  Future<String> signupWithEmailandPassword(String email, String password) async {
    return remoteDataSource.signupWithEmailandPassword(email, password);
  }

  @override
  Future<bool> checkUserExists(String email) async {
    return remoteDataSource.checkUserExists(email);
  }

  @override
  Future<UserEntity?> getUserDataFromLocal()async {
    UserModel? u=await localDataSource.getUserDataFromLocal();
    // print("===============$u");
    if(u!=null){

      UserEntity uu= UserEntity.fromUserModel(u);
      // print("===============$uu");
      return uu;
    }
    return null;
  }

  @override
  Future<UserEntity?> getUserDataFromRemote(String uid) async{
      UserModel? u=await remoteDataSource.getUserDataFromRemote(uid);
      if(u!=null){

      }
      return null;

  }

  @override
  Future<void> saveUserDataToLocal(UserEntity user) async{
    UserModel userModel=UserModel.fromEntity(user);
    return localDataSource.savaUserDataToLocal(userModel);
  }

  @override
  Future<void> saveUserDataToRemote(UserEntity user)async {
    UserModel userModel=UserModel.fromEntity(user);
    return remoteDataSource.saveUserDataToRemote(userModel);
  }

  @override
  Future<String> storeFileToRemote(File file, String uid) async {
    return remoteDataSource.storeFileToRemote(file, uid);
  }


}

