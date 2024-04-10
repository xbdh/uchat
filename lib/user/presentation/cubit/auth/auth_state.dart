part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthSignUpSuccess extends AuthState {
  final String uid;
  const AuthSignUpSuccess(this.uid);
  @override
  List<Object> get props => [];
}
final class AuthSignUpFail extends AuthState {
  @override
  List<Object> get props => [];
}
final class AuthLogInSuccess extends AuthState {
  final String uid;
  const AuthLogInSuccess(this.uid);
  @override
  List<Object> get props => [];
}
final class AuthLogInFail extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthCheckUserExist extends AuthState {
  final  bool isExist;
  const AuthCheckUserExist(this.isExist);
  @override
  List<Object> get props => [isExist];
}

final class AuthInternalError extends AuthState {
  @override
  List<Object> get props => [];
}