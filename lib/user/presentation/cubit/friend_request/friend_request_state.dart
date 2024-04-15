part of 'friend_request_cubit.dart';

sealed class FriendRequestState extends Equatable {
  const FriendRequestState();
}

final class FriendRequestInitial extends FriendRequestState {
  @override
  List<Object> get props => [];
}

final class FriendSuccess extends FriendRequestState {
  @override
  List<Object> get props => [];
}

// final class FriendList extends FriendRequestState {
//   final List<UserEntity> friends;
//   const FriendList(this.friends);
//   @override
//   List<Object> get props => [];
// }
