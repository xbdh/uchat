import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/domain/use_cases/credential/login_usecase.dart';
import 'package:uchat/user/domain/use_cases/credential/signup_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:uchat/user/domain/use_cases/user/save_data.dart';
import 'package:uchat/user/presentation/cubit/auth/auth_cubit.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignUpUseCase signUpUseCase;
  final LogInUseCase logInUseCase;
  final SavaDataUseCase saveUserUseCase;

  CredentialCubit({
    required this.signUpUseCase,
    required this.logInUseCase,
    required this.saveUserUseCase
  }) : super(CredentialInitial());

  Future<void> submitSignUp({required String email, required String password}) async {
    try {
      String uid=await signUpUseCase(email, password);
      // if uid start with *
      if(uid.startsWith('*')){
        emit(CredentialFailure(
          errorMessage: uid
        ));
        return;
      }
      emit(CredentialSignupSuccess(
        uid: uid
      ));
    } catch (_) {
      emit(const CredentialFailure(
        errorMessage: 'Sign up failed'
      ));
    }
  }
  Future<void> submitLogIn({required String email, required String password}) async {
    try {
      String uid=await logInUseCase.call(email, password);
      if (uid.startsWith('*')) {
        emit(CredentialFailure(
          errorMessage: uid
        ));
        return;
      }
      emit(CredentialLoginSuccess(
        uid: uid
      ));
    } catch (_) {
      emit(const CredentialFailure(
        errorMessage: 'Log in failed'
      ));
    }
  }

  Future<void> submitInfo({required UserEntity user, required File? avatarFile}) async {
    try {
      await saveUserUseCase(user,avatarFile);
      emit(CredentialInfoSuccess());
    } on SocketException catch (_) {
      emit(const CredentialFailure(
        errorMessage: 'No internet connection'
      ));
    } catch (_) {
      emit(const CredentialFailure(
        errorMessage: 'Save user failed'
      ));
    }
  }
}
