

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/chat/domain/entities/message_reply_entity.dart';

class MessageReplyModel  extends Equatable {
  final String message;
  final String senderUID;
  final String senderName;
  final String senderImage;
  final MessageType messageType;
  final bool isMe;

  const MessageReplyModel({
    required this.message,
    required this.senderUID,
    required this.senderName,
    required this.senderImage,
    required this.messageType,
    required this.isMe,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    message,
    senderUID,
    senderName,
    senderImage,
    messageType,
    isMe,
  ];

  factory MessageReplyModel.fromMap(Map<String, dynamic> map) {
    return MessageReplyModel(
      message: map['message'],
      senderUID: map['senderUID'],
      senderName: map['senderName'],
      senderImage: map['senderImage'],
      messageType: MessageTypeExtension.fromString(map['messageType']),
      isMe: map['isMe'],
    );
  }

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'senderUID': senderUID,
      'senderName': senderName,
      'senderImage': senderImage,
      'messageType': messageType.toShortString(),
      'isMe': isMe,
    };
  }
  // from snapshot
  factory MessageReplyModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return MessageReplyModel(
      message: snap['message'],
      senderUID: snap['senderUID'],
      senderName: snap['senderName'],
      senderImage: snap['senderImage'],
      messageType: MessageTypeExtension.fromString(snap['messageType']),
      isMe: snap['isMe'],
    );
  }

  // from Message_reply_entiy
  factory MessageReplyModel.fromEntity(MessageReplyEntity entity) {
    return MessageReplyModel(
      message: entity.message,
      senderUID: entity.senderUID,
      senderName: entity.senderName,
      senderImage: entity.senderImage,
      messageType: entity.messageType,
      isMe: entity.isMe,
    );
  }

}