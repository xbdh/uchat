part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final String uid;

  const Authenticated({required this.uid});
  @override
  List<Object> get props => [uid];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthLogOutSuccess extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLogOutFail extends AuthState {
  @override
  List<Object> get props => [];
}