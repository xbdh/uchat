
import 'package:uchat/user/data/models/user_model.dart';

import 'package:uchat/user/data/data_sources/remote/user_remote_data_sources.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/domain/repositories/user_repositories.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

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
  Stream<List<UserEntity>> getSingleUser(String uid) {
    Stream<List<UserModel>> userModel=remoteDataSource.getSingleUser(uid);
    Stream<List<UserEntity>> userEntity=userModel.map((event) => event.map((e) => UserEntity.fromUserModel(e)).toList());
    return userEntity;
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
  }

