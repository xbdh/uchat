import 'package:equatable/equatable.dart';
import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/chat/data/models/group_model.dart';

class GroupEntity  extends Equatable {
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

  const GroupEntity({
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
  GroupEntity copyWith({
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
    return GroupEntity(
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

  // factory from GroupModel

  factory GroupEntity.fromGroupModel(GroupModel groupModel){
    return GroupEntity(
      creatorUID: groupModel.creatorUID,
      groupName: groupModel.groupName,
      groupDescription: groupModel.groupDescription,
      groupImage: groupModel.groupImage,
      groupId: groupModel.groupId,
      lastMessage: groupModel.lastMessage,
      senderUID: groupModel.senderUID,
      messageType: groupModel.messageType,
      messageId: groupModel.messageId,
      timeSent: groupModel.timeSent,
      createdAt: groupModel.createdAt,
      isPrivate: groupModel.isPrivate,
      editSettings: groupModel.editSettings,
      approveMembers: groupModel.approveMembers,
      lockMessages: groupModel.lockMessages,
      requestToJoin: groupModel.requestToJoin,
      membersUIDs: groupModel.membersUIDs,
      adminsUIDs: groupModel.adminsUIDs,
      awaitingApprovalUIDs: groupModel.awaitingApprovalUIDs,
    );

  }

}