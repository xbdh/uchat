
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/chat/domain/entities/message_entity.dart';

class MessageModel extends Equatable {
  final String senderUID;
  final String senderName;
  final String senderImage;
  final String recipientUID;
  final String message;
  final MessageType messageType;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  final String repliedMessage;
  final String repliedTo;
  final MessageType repliedMessageType;
  final List<String> reactions;
  final List<String> isSeenBy;
  final List<String> deletedBy;

  const MessageModel({
    required this.senderUID,
    required this.senderName,
    required this.senderImage,
    required this.recipientUID,
    required this.message,
    required this.messageType,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
    required this.reactions,
    required this.isSeenBy,
    required this.deletedBy,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    senderUID,
    senderName,
    senderImage,
    recipientUID,
    message,
    messageType,
    timeSent,
    messageId,
    isSeen,
    repliedMessage,
    repliedTo,
    repliedMessageType,
    reactions,
    isSeenBy,
    deletedBy,
  ];

  factory MessageModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return MessageModel(
      senderUID: snap['senderUID'],
      senderName: snap['senderName'],
      senderImage: snap['senderImage'],
      recipientUID: snap['recipientUID'],
      message: snap['message'],
      messageType: MessageTypeExtension.fromString(snap['messageType']),
      timeSent: snap['timeSent'].toDate(),
      messageId: snap['messageId'],
      isSeen: snap['isSeen'],
      repliedMessage: snap['repliedMessage'],
      repliedTo: snap['repliedTo'],
      repliedMessageType: MessageTypeExtension.fromString(snap['repliedMessageType']),
      reactions: List<String>.from(snap['reactions']),
      isSeenBy: List<String>.from(snap['isSeenBy']),
      deletedBy: List<String>.from(snap['deletedBy']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderUID': senderUID,
      'senderName': senderName,
      'senderImage': senderImage,
      'recipientUID': recipientUID,
      'message': message,
      'messageType': messageType.toShortString(),
      'timeSent': timeSent,
      'messageId': messageId,
      'isSeen': isSeen,
      'repliedMessage': repliedMessage,
      'repliedTo': repliedTo,
      'repliedMessageType': repliedMessageType.toShortString(),
      'reactions': reactions,
      'isSeenBy': isSeenBy,
      'deletedBy': deletedBy,
    };
  }

 factory MessageModel.fromEntity(MessageEntity entity) {
    return MessageModel(
      senderUID: entity.senderUID,
      senderName: entity.senderName,
      senderImage: entity.senderImage,
      recipientUID: entity.recipientUID,
      message: entity.message,
      messageType: entity.messageType,
      timeSent: entity.timeSent,
      messageId: entity.messageId,
      isSeen: entity.isSeen,
      repliedMessage: entity.repliedMessage,
      repliedTo: entity.repliedTo,
      repliedMessageType: entity.repliedMessageType,
      reactions: entity.reactions,
      isSeenBy: entity.isSeenBy,
      deletedBy: entity.deletedBy,
    );
  }

  factory MessageModel.fromMap(Map<String, dynamic> map){
    return MessageModel(
      senderUID: map['senderUID'],
      senderName: map['senderName'],
      senderImage: map['senderImage'],
      recipientUID: map['recipientUID'],
      message: map['message'],
      messageType: MessageType.values[map['messageType']],
      timeSent: map['timeSent'].toDate(),
      messageId: map['messageId'],
      isSeen: map['isSeen'],
      repliedMessage: map['repliedMessage'],
      repliedTo: map['repliedTo'],
      repliedMessageType: MessageType.values[map['repliedMessageType']],
      reactions: List<String>.from(map['reactions']),
      isSeenBy: List<String>.from(map['isSeenBy']),
      deletedBy: List<String>.from(map['deletedBy']),
    );
  }

}