import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/domain/use_cases/auth/login_usecase.dart';
import 'package:uchat/user/domain/use_cases/auth/signup_usecase.dart';
import 'package:uchat/user/domain/use_cases/auth/check_user_exists_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LogInUseCase logInUseCase;
  final SignUpUseCase signUpUseCase;
  final CheckUserExistsUseCase userCheckExistUseCase;
  AuthCubit({required this.logInUseCase, required this.signUpUseCase,required this.userCheckExistUseCase}) : super(AuthInitial());

  Future<void> submitSignUp({required String email, required String password}) async {
    try {
      String uid=await signUpUseCase(email, password);
      _uid=uid;
      _email=email;
      emit(AuthSignUpSuccess(
        uid
      ));
    } catch (_) {
      emit(AuthSignUpFail());
    }
  }
  Future<void> submitLogIn({required String email, required String password}) async {
    try {
      String uid=await logInUseCase.call(email, password);
      _uid=uid;
      _email=email;
      emit(AuthLogInSuccess(
        uid
      ));
    } catch (_) {
      emit(AuthLogInFail());
    }
  }

  Future<void> checkUserExists(String email) async {
    try {
      final isExist = await userCheckExistUseCase.call(email);
      emit(AuthCheckUserExist(isExist));
    } catch (_) {
      emit(AuthInternalError());
    }
  }
  String? _uid;
  String? _email;
  UserEntity? _user;

  String? get uid => _uid; // get function
  String? get email => _email;
  UserEntity? get user => _user;

  // get function

}
