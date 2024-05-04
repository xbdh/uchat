import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:uchat/main.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/domain/use_cases/credential/check_user_exists_usecase.dart';
import 'package:uchat/user/domain/use_cases/user/bind_fcm_token_usecase.dart';
import 'package:uchat/user/domain/use_cases/user/get_all_user_usecase.dart';
import 'package:uchat/user/domain/use_cases/user/get_data_local_usecase.dart';

import 'package:uchat/user/domain/use_cases/user/save_data.dart';
import 'package:uchat/user/domain/use_cases/user/set_user_online_status_usecase.dart';

import '../../../domain/use_cases/user/get_fcm_token_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final CheckUserExistsUseCase userCheckExistUseCase;
  final SavaDataUseCase savaDataUseCase;
  final GetDataLocalUseCase getDataLocalUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;
  final SetUserOnlineStatusUseCase setUserOnlineStatusUseCase;
  final BindFcmTokenUseCase bindFcmTokenUseCase;
  final GetFcmTokenUseCase getFcmTokenUseCase;

  UserEntity? userEntity;

  UserCubit( {
    required this.bindFcmTokenUseCase,
    required this.userCheckExistUseCase,
    required this.savaDataUseCase,
    required this.getDataLocalUseCase,
    required this.getAllUsersUseCase,
    required this.setUserOnlineStatusUseCase,
    required this.getFcmTokenUseCase,
  }) : super(UserInitial());
  Future<void> checkUserExist(String id) async {
    try {
      final isExist = await userCheckExistUseCase.call(id);
      if (isExist) {
        emit(const UserCheckExist(true));
      } else {
        emit(const UserCheckExist(false));
      }
    } catch (_) {
      emit(UserError());
    }
  }

  Future<void> saveData(UserEntity user,File? fileAvatar) async {
    logger.d('++saveData $user , $fileAvatar');
    try {
      emit(UserLoading());
      UserEntity uu=await savaDataUseCase.call(user,fileAvatar);
      userEntity = uu;
      emit(UserSavaDataSuccess());
    } catch (_) {
      emit(UserSavaDataFail());
    }
  }
  Future<void> getDataLocal() async {
   try {

      final user = await getDataLocalUseCase.call();
      // print('getDataLocal++++ userEntity: $user');
      userEntity = user;
      emit(UserGetDataLocalSuccess(
        user!,
      ));
      // print('userEntity: $userEntity');
    } catch (_) {
      emit(UserGetDataLocalFail());
    }
  }

  Future<void> getAllUser(bool includeMe) async {
    try {
      emit(UserLoading());
      final streamResponse = getAllUsersUseCase.call(includeMe);
      streamResponse.listen((users) {
        if (includeMe) {
          emit(GetAllUserLoaded(allUser: users));

        }else{
          emit(GetUsersExpectMeLoaded(allUser: users));
        }
      });
    } on Exception catch (e) {
      emit(UserGetAllUsersFail());
    }
  }

  Future<void> setUserOnlineStatus(bool isOnline) async {

      await setUserOnlineStatusUseCase.call(isOnline);

  }
  Future<void> bindFcmToken(String uid) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
     logger.d('bindFcmToken $uid, $fcmToken');
    await bindFcmTokenUseCase.call(uid, fcmToken!);
  }
  Future<String> getFcmToken(String uid) async {
    final st=await getFcmTokenUseCase.call(uid);
    return st;
  }
}
