part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();
}

final class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

final class UserCheckExist extends UserState {
  final  bool isExist;
  const UserCheckExist(this.isExist);
  @override
  List<Object> get props => [isExist];
}

final class UserError extends UserState {
  @override
  List<Object> get props => [];
}
final class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

final class UserSavaDataSuccess extends UserState {
  @override
  List<Object> get props => [];
}
final class UserSavaDataFail extends UserState {
  @override
  List<Object> get props => [];
}

final class UserGetDataLocalSuccess extends UserState {
  UserEntity userEntity;
  UserGetDataLocalSuccess(this.userEntity);
  @override
  List<Object> get props => [];
}
final class UserGetDataLocalFail extends UserState {
  @override
  List<Object> get props => [];
}

class GetAllUserLoaded extends UserState {
  final List<UserEntity> allUser;

  const GetAllUserLoaded({required this.allUser});
  @override
  List<Object> get props => [allUser];
}

class GetUsersExpectMeLoaded extends UserState {
  final List<UserEntity> allUser;

  const GetUsersExpectMeLoaded({required this.allUser});
  @override
  List<Object> get props => [allUser];
}

final class UserGetAllUsersFail extends UserState {
  @override
  List<Object> get props => [];
}