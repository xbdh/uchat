part of 'friend_request_cubit.dart';

sealed class FriendRequestState extends Equatable {
  const FriendRequestState();

}

final class FriendRequestInitial extends FriendRequestState {
  @override
  List<Object> get props => [];
}

final class FriendRequestAccepted extends FriendRequestState {
  @override
  List<Object> get props => [];
}

final class FriendRequestCancled extends FriendRequestState {
  @override
  List<Object> get props => [];
}

final class FriendRequestSent extends FriendRequestState {
  @override
  List<Object> get props => [];
}

final class FriendRemoved extends FriendRequestState {
  @override
  List<Object> get props => [];
}

final class FriendList extends FriendRequestState {
  final List<UserEntity> friends;
   const FriendList(this.friends);
  @override
  List<Object> get props => [friends];
}

final class FriendRequestList extends FriendRequestState {
  final List<UserEntity> requestFriends;
   const FriendRequestList(this.requestFriends);
  @override
  List<Object> get props => [requestFriends];
}

final class FriendRequestFailed extends FriendRequestState {
  @override
  List<Object> get props => [];
}