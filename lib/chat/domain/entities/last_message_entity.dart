

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/chat/data/models/last_message_model.dart';

class LastMessageEntity  extends Equatable {
  String senderUID;
  String recipientUID;
  String recipientName;
  String recipientImage;
  String message;
  MessageType messageType;
  DateTime timeSent;
  bool isSeen;

  LastMessageEntity({
    required this.senderUID,
    required this.recipientUID,
    required this.recipientName,
    required this.recipientImage,
    required this.message,
    required this.messageType,
    required this.timeSent,
    required this.isSeen,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    senderUID,
    recipientUID,
    recipientName,
    recipientImage,
    message,
    messageType,
    timeSent,
    isSeen,
  ];

  factory LastMessageEntity.fromChatModel(LastMessageModel chatModel) {
    return LastMessageEntity(
      senderUID: chatModel.senderUID,
      recipientUID: chatModel.recipientUID,
      recipientName: chatModel.recipientName,
      recipientImage: chatModel.recipientImage,
      message: chatModel.message,
      messageType: chatModel.messageType,
      timeSent: chatModel.timeSent,
      isSeen: chatModel.isSeen,
    );
  }

  LastMessageEntity copyWith({
    String? senderUID,
    String? recipientUID,
    String? recipientName,
    String? recipientImage,
    String? message,
    MessageType? messageType,
    DateTime? timeSent,
    bool? isSeen,
  }) {
    return LastMessageEntity(
      senderUID: senderUID ?? this.senderUID,
      recipientUID: recipientUID ?? this.recipientUID,
      recipientName: recipientName ?? this.recipientName,
      recipientImage: recipientImage ?? this.recipientImage,
      message: message ?? this.message,
      messageType: messageType ?? this.messageType,
      timeSent: timeSent ?? this.timeSent,
      isSeen: isSeen ?? this.isSeen,
    );
  }

}