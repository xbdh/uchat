part of 'get_user_cubit.dart';

sealed class GetUserState extends Equatable {
  const GetUserState();
}

final class GetUserInitial extends GetUserState {
  @override
  List<Object> get props => [];
}

class GetUserLoading extends GetUserState {
  @override
  List<Object> get props => [];
}

class GetSingleUserLoaded extends GetUserState {
  final UserEntity singleUser;

  const GetSingleUserLoaded({required this.singleUser});
  @override
  List<Object> get props => [singleUser];
}



class GetAllUserLoaded extends GetUserState {
  final List<UserEntity> allUser;

  const GetAllUserLoaded({required this.allUser});
  @override
  List<Object> get props => [allUser];
}

class GetUsersExpectMeLoaded extends GetUserState {
  final List<UserEntity> allUser;

  const GetUsersExpectMeLoaded({required this.allUser});
  @override
  List<Object> get props => [allUser];
}


class GetUserFailure extends GetUserState {
  @override
  List<Object> get props => [];
}

