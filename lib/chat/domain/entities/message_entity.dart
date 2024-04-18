
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/chat/data/models/message_model.dart';

class MessageEntity extends Equatable {
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

  const MessageEntity({
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

  factory MessageEntity.fromMessageModel(MessageModel messageModel) {
    return MessageEntity(
      senderUID: messageModel.senderUID,
      senderName: messageModel.senderName,
      senderImage: messageModel.senderImage,
      recipientUID: messageModel.recipientUID,
      message: messageModel.message,
      messageType: messageModel.messageType,
      timeSent: messageModel.timeSent,
      messageId: messageModel.messageId,
      isSeen: messageModel.isSeen,
      repliedMessage: messageModel.repliedMessage,
      repliedTo: messageModel.repliedTo,
      repliedMessageType: messageModel.repliedMessageType,
      reactions: messageModel.reactions,
      isSeenBy: messageModel.isSeenBy,
      deletedBy: messageModel.deletedBy,
    );
  }

  MessageEntity copyWith({
    String? senderUID,
    String? senderName,
    String? senderImage,
    String? recipientUID,
    String? message,
    MessageType? messageType,
    DateTime? timeSent,
    String? messageId,
    bool? isSeen,
    String? repliedMessage,
    String? repliedTo,
    MessageType? repliedMessageType,
    List<String>? reactions,
    List<String>? isSeenBy,
    List<String>? deletedBy,
  }) {
    return MessageEntity(
      senderUID: senderUID ?? this.senderUID,
      senderName: senderName ?? this.senderName,
      senderImage: senderImage ?? this.senderImage,
      recipientUID: recipientUID ?? this.recipientUID,
      message: message ?? this.message,
      messageType: messageType ?? this.messageType,
      timeSent: timeSent ?? this.timeSent,
      messageId: messageId ?? this.messageId,
      isSeen: isSeen ?? this.isSeen,
      repliedMessage: repliedMessage ?? this.repliedMessage,
      repliedTo: repliedTo ?? this.repliedTo,
      repliedMessageType: repliedMessageType ?? this.repliedMessageType,
      reactions: reactions ?? this.reactions,
      isSeenBy: isSeenBy ?? this.isSeenBy,
      deletedBy: deletedBy ?? this.deletedBy,
    );
  }


}