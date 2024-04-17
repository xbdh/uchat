part of 'friend_list_cubit.dart';

sealed class FriendListState extends Equatable {
  const FriendListState();
}

final class FriendListInitial extends FriendListState {
  @override
  List<Object> get props => [];
}

final class FriendListLoaded extends FriendListState {
  final List<UserEntity> friends;
  const FriendListLoaded({required this.friends});
  @override
  List<Object> get props => [friends];
}

final class FriendListFailed extends FriendListState {
  @override
  List<Object> get props => [];
}


// final class FriendList extends FriendRequestState {
//   final List<UserEntity> friends;
//   const FriendList(this.friends);
//   @override
//   List<Object> get props => [friends];
// }
//
// final class FriendRequestList extends FriendRequestState {
//   final List<UserEntity> requestFriends;
//   const FriendRequestList(this.requestFriends);
//   @override
//   List<Object> get props => [requestFriends];
// }
