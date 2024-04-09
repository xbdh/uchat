
import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';

class UserEntity extends Equatable {
  final String uid;
  final String name;
  final String phoneNumber;
  final String image;
  final String token;
  final String aboutMe;
  final String status;
  final String lastSeen;
  final String createdAt;
  final bool isOnline;
  final List<String> friendsUIDs;
  final List<String> getFriendRequestsUIDs;
  final List<String> sentFriendRequestsUIDs;

  const UserEntity({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    required this.image,
    required this.token,
    required this.aboutMe,
    required this.status,
    required this.lastSeen,
    required this.createdAt,
    required this.isOnline,
    required this.friendsUIDs,
    required this.getFriendRequestsUIDs,
    required this.sentFriendRequestsUIDs,
  });

  @override
  List<Object?> get props => [
    uid,
    name,
    phoneNumber,
    image,
    token,
    aboutMe,
    status,
    lastSeen,
    createdAt,
    isOnline,
    friendsUIDs,
    getFriendRequestsUIDs,
    sentFriendRequestsUIDs,
  ];

  factory UserEntity.fromUserModel(UserModel userModel) {
    return UserEntity(
      uid: userModel.uid,
      name: userModel.name,
      phoneNumber: userModel.phoneNumber,
      image: userModel.image,
      token: userModel.token,
      aboutMe: userModel.aboutMe,
      status: userModel.status,
      lastSeen: userModel.lastSeen,
      createdAt: userModel.createdAt,
      isOnline: userModel.isOnline,
      friendsUIDs: userModel.friendsUIDs,
      getFriendRequestsUIDs: userModel.getFriendRequestsUIDs,
      sentFriendRequestsUIDs: userModel.sentFriendRequestsUIDs,
    );
  }
}