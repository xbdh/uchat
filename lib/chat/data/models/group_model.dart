import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/chat/domain/entities/group_entity.dart';

class GroupModel  extends Equatable {
  final String creatorUID;
  final String groupName;
  final String groupDescription;
  final String groupImage;
  final String groupId;
  final String lastMessage;
  final String senderUID;
  final  MessageType messageType;
  final String messageId;
  final DateTime timeSent;
  final DateTime createdAt;
  final bool isPrivate;
  final bool editSettings;
  final bool approveMembers;
  final bool lockMessages;
  final bool requestToJoin;
  final List<String> membersUIDs;
  final List<String> adminsUIDs;
  final List<String> awaitingApprovalUIDs;

  const GroupModel({
    required this.creatorUID,
    required this.groupName,
    required this.groupDescription,
    required this.groupImage,
    required this.groupId,
    required this.lastMessage,
    required this.senderUID,
    required this.messageType,
    required this.messageId,
    required this.timeSent,
    required this.createdAt,
    required this.isPrivate,
    required this.editSettings,
    required this.approveMembers,
    required this.lockMessages,
    required this.requestToJoin,
    required this.membersUIDs,
    required this.adminsUIDs,
    required this.awaitingApprovalUIDs,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    creatorUID,
    groupName,
    groupDescription,
    groupImage,
    groupId,
    lastMessage,
    senderUID,
    messageType,
    messageId,
    timeSent,
    createdAt,
    isPrivate,
    editSettings,
    approveMembers,
    lockMessages,
    requestToJoin,
    membersUIDs,
    adminsUIDs,
    awaitingApprovalUIDs,
  ];

  // copy with
  GroupModel copyWith({
    String? creatorUID,
    String? groupName,
    String? groupDescription,
    String? groupImage,
    String? groupId,
    String? lastMessage,
    String? senderUID,
    MessageType? messageType,
    String? messageId,
    DateTime? timeSent,
    DateTime? createdAt,
    bool? isPrivate,
    bool? editSettings,
    bool? approveMembers,
    bool? lockMessages,
    bool? requestToJoin,
    List<String>? membersUIDs,
    List<String>? adminsUIDs,
    List<String>? awaitingApprovalUIDs,
  }) {
    return GroupModel(
      creatorUID: creatorUID ?? this.creatorUID,
      groupName: groupName ?? this.groupName,
      groupDescription: groupDescription ?? this.groupDescription,
      groupImage: groupImage ?? this.groupImage,
      groupId: groupId ?? this.groupId,
      lastMessage: lastMessage ?? this.lastMessage,
      senderUID: senderUID ?? this.senderUID,
      messageType: messageType ?? this.messageType,
      messageId: messageId ?? this.messageId,
      timeSent: timeSent ?? this.timeSent,
      createdAt: createdAt ?? this.createdAt,
      isPrivate: isPrivate ?? this.isPrivate,
      editSettings: editSettings ?? this.editSettings,
      approveMembers: approveMembers ?? this.approveMembers,
      lockMessages: lockMessages ?? this.lockMessages,
      requestToJoin: requestToJoin ?? this.requestToJoin,
      membersUIDs: membersUIDs ?? this.membersUIDs,
      adminsUIDs: adminsUIDs ?? this.adminsUIDs,
      awaitingApprovalUIDs: awaitingApprovalUIDs ?? this.awaitingApprovalUIDs,
    );
  }

// factory from GroupEntity

 factory GroupModel.fromGroupEntity(GroupEntity groupEntity) {
    return GroupModel(
      creatorUID: groupEntity.creatorUID,
      groupName: groupEntity.groupName,
      groupDescription: groupEntity.groupDescription,
      groupImage: groupEntity.groupImage,
      groupId: groupEntity.groupId,
      lastMessage: groupEntity.lastMessage,
      senderUID: groupEntity.senderUID,
      messageType: groupEntity.messageType,
      messageId: groupEntity.messageId,
      timeSent: groupEntity.timeSent,
      createdAt: groupEntity.createdAt,
      isPrivate: groupEntity.isPrivate,
      editSettings: groupEntity.editSettings,
      approveMembers: groupEntity.approveMembers,
      lockMessages: groupEntity.lockMessages,
      requestToJoin: groupEntity.requestToJoin,
      membersUIDs: groupEntity.membersUIDs,
      adminsUIDs: groupEntity.adminsUIDs,
      awaitingApprovalUIDs: groupEntity.awaitingApprovalUIDs,
    );
  }

   //Map fuction
  Map<String, dynamic> toMap() {
    return {
      'creatorUID': creatorUID,
      'groupName': groupName,
      'groupDescription': groupDescription,
      'groupImage': groupImage,
      'groupId': groupId,
      'lastMessage': lastMessage,
      'senderUID': senderUID,
      'messageType': messageType.toShortString(),
      'messageId': messageId,
      'timeSent': timeSent,
      'createdAt': createdAt,
      'isPrivate': isPrivate,
      'editSettings': editSettings,
      'approveMembers': approveMembers,
      'lockMessages': lockMessages,
      'requestToJoin': requestToJoin,
      'membersUIDs': membersUIDs,
      'adminsUIDs': adminsUIDs,
      'awaitingApprovalUIDs': awaitingApprovalUIDs,
    };
  }
  // factory from firebase snapshot
  factory GroupModel.fromSnapshot(DocumentSnapshot snapshot){
    final map = snapshot.data() as Map<String, dynamic>;
    return GroupModel(
      creatorUID: map['creatorUID'],
      groupName: map['groupName'],
      groupDescription: map['groupDescription'],
      groupImage: map['groupImage'],
      groupId: map['groupId'],
      lastMessage: map['lastMessage'],
      senderUID: map['senderUID'],
      messageType: MessageTypeExtension.fromString(map['messageType']),
      messageId: map['messageId'],
      timeSent: map['timeSent'].toDate(),
      createdAt: map['createdAt'].toDate(),
      isPrivate: map['isPrivate'],
      editSettings: map['editSettings'],
      approveMembers: map['approveMembers'],
      lockMessages: map['lockMessages'],
      requestToJoin: map['requestToJoin'],
      membersUIDs: List<String>.from(map['membersUIDs']),
      adminsUIDs: List<String>.from(map['adminsUIDs']),
      awaitingApprovalUIDs: List<String>.from(map['awaitingApprovalUIDs']),
    );
  }
}