
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

class UserModel extends Equatable  {
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

  const UserModel({
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

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;


    return UserModel(
      uid: snap['uid'],
      name: snap['name'],
      email: snap['email'],
      image: snap['image'],
      token: snap['token'],
      aboutMe: snap['aboutMe'],
      status: snap['status'],
      lastSeen: snap['lastSeen'],
      createdAt: snap['createdAt'],
      isOnline: snap['isOnline'],
      fcmToken: snap['fcmToken'],
      friendsUIDs: List<String>.from(snap['friendsUIDs']),
      friendRequestsFromUIDs: List<String>.from(snap['friendRequestsFromUIDs']),
      sentFriendRequestsToUIDs: List<String>.from(snap['sentFriendRequestsToUIDs']),
    );
  }
  Map<String, dynamic> toMap() =>{
    'uid': uid,
    'name': name,
    'email': email,
    'image': image,
    'token': token,
    'aboutMe': aboutMe,
    'status': status,
    'lastSeen': lastSeen,
    'createdAt': createdAt,
    'isOnline': isOnline,
    'fcmToken': fcmToken,
    'friendsUIDs': friendsUIDs,
    'friendRequestsFromUIDs': friendRequestsFromUIDs,
    'sentFriendRequestsToUIDs': sentFriendRequestsToUIDs,
  };

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      image: map['image'],
      token: map['token'],
      aboutMe: map['aboutMe'],
      status: map['status'],
      lastSeen: map['lastSeen'],
      createdAt: map['createdAt'],
      isOnline: map['isOnline'],
      fcmToken: map['fcmToken'],
      friendsUIDs: List<String>.from(map['friendsUIDs']),
      friendRequestsFromUIDs: List<String>.from(map['friendRequestsFromUIDs']),
      sentFriendRequestsToUIDs: List<String>.from(map['sentFriendRequestsToUIDs']),
    );
  }

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

   factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      name: entity.name,
      email: entity.email,
      image: entity.image,
      token: entity.token,
      aboutMe: entity.aboutMe,
      status: entity.status,
      lastSeen: entity.lastSeen,
      createdAt: entity.createdAt,
      isOnline: entity.isOnline,
      fcmToken: entity.fcmToken,
      friendsUIDs: entity.friendsUIDs,
      friendRequestsFromUIDs: entity.friendRequestsFromUIDs,
      sentFriendRequestsToUIDs: entity.sentFriendRequestsToUIDs,
    );
  }


  }