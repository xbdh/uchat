import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/domain/use_cases/auth/check_user_exists_usecase.dart';

import 'package:uchat/user/domain/use_cases/user/sava_data.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final CheckUserExistsUseCase userCheckExistUseCase;
  final SavaDataUseCase savaDataUseCase;
  UserEntity? userEntity;

  UserCubit({required this.userCheckExistUseCase,required this.savaDataUseCase}) : super(UserInitial());
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
    try {
      emit(UserLoading());
      await savaDataUseCase.call(user,fileAvatar);
      userEntity = user;
      emit(UserSavaDataSuccess());
    } catch (_) {
      emit(UserSavaDataFail());
    }
  }
}
