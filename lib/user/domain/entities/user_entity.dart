
import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';

class UserEntity extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String image;
  final String token;
  final String aboutMe;
  final String status;
  final String lastSeen;
  final String createdAt;
  final bool isOnline;
  final String fcmToken ;
  final List<String> friendsUIDs;
  final List<String> friendRequestsFromUIDs;
  final List<String> sentFriendRequestsToUIDs;

  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,
    required this.token,
    required this.aboutMe,
    required this.status,
    required this.lastSeen,
    required this.createdAt,
    required this.isOnline,
    required this.fcmToken ,
    required this.friendsUIDs,
    required this.friendRequestsFromUIDs,
    required this.sentFriendRequestsToUIDs,
  });

  @override
  List<Object?> get props => [
    uid,
    name,
    email,
    image,
    token,
    aboutMe,
    status,
    lastSeen,
    createdAt,
    isOnline,
    fcmToken,
    friendsUIDs,
    friendRequestsFromUIDs,
    sentFriendRequestsToUIDs,
  ];

  factory UserEntity.fromUserModel(UserModel userModel) {
    return UserEntity(
      uid: userModel.uid,
      name: userModel.name,
      email: userModel.email,
      image: userModel.image,
      token: userModel.token,
      aboutMe: userModel.aboutMe,
      status: userModel.status,
      lastSeen: userModel.lastSeen,
      createdAt: userModel.createdAt,
      isOnline: userModel.isOnline,
      fcmToken: userModel.fcmToken,
      friendsUIDs: userModel.friendsUIDs,
      friendRequestsFromUIDs: userModel.friendRequestsFromUIDs,
      sentFriendRequestsToUIDs: userModel.sentFriendRequestsToUIDs,
    );
  }

  UserEntity copyWith({
    String? uid,
    String? name,
    String? email,
    String? image,
    String? token,
    String? aboutMe,
    String? status,
    String? lastSeen,
    String? createdAt,
    bool? isOnline,
    String? fcmToken,
    List<String>? friendsUIDs,
    List<String>? friendRequestsFromUIDs,
    List<String>? sentFriendRequestsToUIDs,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      token: token ?? this.token,
      aboutMe: aboutMe ?? this.aboutMe,
      status: status ?? this.status,
      lastSeen: lastSeen ?? this.lastSeen,
      createdAt: createdAt ?? this.createdAt,
      isOnline: isOnline ?? this.isOnline,
      fcmToken: fcmToken ?? this.fcmToken,
      friendsUIDs: friendsUIDs ?? this.friendsUIDs,
      friendRequestsFromUIDs: friendRequestsFromUIDs ?? this.friendRequestsFromUIDs,
      sentFriendRequestsToUIDs: sentFriendRequestsToUIDs ?? this.sentFriendRequestsToUIDs,
    );
  }
}