import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/domain/use_cases/credential/get_current_uid.dart';
import 'package:uchat/user/domain/use_cases/credential/is_signin_usecase.dart';
import 'package:uchat/user/domain/use_cases/credential/login_usecase.dart';
import 'package:uchat/user/domain/use_cases/credential/signout_usecase.dart';
import 'package:uchat/user/domain/use_cases/credential/signup_usecase.dart';
import 'package:uchat/user/domain/use_cases/credential/check_user_exists_usecase.dart';
import 'package:uchat/user/domain/use_cases/user/get_data_remote_usecase.dart';
import 'package:uchat/user/domain/use_cases/user/save_data_local_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final IsSignInUseCase isSignInUseCase;
  final SignOutUseCase signOutUseCase;
  final GetDataRemoteUseCase getDataRemoteUseCase;
  final SaveDataLocalUseCase saveDataLocalUseCase;

  AuthCubit({
    required this.getCurrentUidUseCase,
    required this.isSignInUseCase,
    required this.signOutUseCase,
    required this.getDataRemoteUseCase,
    required this.saveDataLocalUseCase,
  }) : super(AuthInitial());

  Future<void> appStarted() async{

    try{
      bool isSignIn=await isSignInUseCase.call();

      // print("+++++++++isSignIn: $isSignIn");
      if (isSignIn){
        final uid=await getCurrentUidUseCase.call();
        // print('+++++++++uid: $uid');
        UserEntity? u=await getDataRemoteUseCase.call(uid);
        // print('+++++++++u: $u');
        if(u!=null){
          await saveDataLocalUseCase.call(u);
        }

        emit(Authenticated(uid: uid));
      }else {
        emit(UnAuthenticated());
      }

    }catch(_){
      emit(UnAuthenticated());
    }

  }

  Future<void> loggedIn() async{
    try{
      final uid= await getCurrentUidUseCase.call();
      emit(Authenticated(uid: uid));
    }catch(_){
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async{
    try{
      await signOutUseCase.call();
      emit(UnAuthenticated());
    }catch(_){
      emit(UnAuthenticated());
    }
  }
}