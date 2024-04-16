import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uchat/main.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/domain/use_cases/credential/check_user_exists_usecase.dart';
import 'package:uchat/user/domain/use_cases/user/get_all_user_usecase.dart';
import 'package:uchat/user/domain/use_cases/user/get_data_local_usecase.dart';

import 'package:uchat/user/domain/use_cases/user/save_data.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final CheckUserExistsUseCase userCheckExistUseCase;
  final SavaDataUseCase savaDataUseCase;
  final GetDataLocalUseCase getDataLocalUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;

  UserEntity? userEntity;

  UserCubit({
    required this.userCheckExistUseCase,
    required this.savaDataUseCase,
    required this.getDataLocalUseCase,
    required this.getAllUsersUseCase,
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
}
