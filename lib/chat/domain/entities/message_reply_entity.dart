import 'package:equatable/equatable.dart';
import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/chat/data/models/message_reply_model.dart';

class MessageReplyEntity extends Equatable {
  final String message;
  final String senderUID;
  final String senderName;
  final String senderImage;
  final MessageType messageType;
  final bool isMe;

  const MessageReplyEntity({
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

  factory MessageReplyEntity.fromMessageReplyModel(
      MessageReplyModel messageReplyModel) {
    return MessageReplyEntity(
      message: messageReplyModel.message,
      senderUID: messageReplyModel.senderUID,
      senderName: messageReplyModel.senderName,
      senderImage: messageReplyModel.senderImage,
      messageType: messageReplyModel.messageType,
      isMe: messageReplyModel.isMe,
    );
  }

  MessageReplyEntity copyWith({
    String? message,
    String? senderUID,
    String? senderName,
    String? senderImage,
    MessageType? messageType,
    bool? isMe,
  }) {
    return MessageReplyEntity(
      message: message ?? this.message,
      senderUID: senderUID ?? this.senderUID,
      senderName: senderName ?? this.senderName,
      senderImage: senderImage ?? this.senderImage,
      messageType: messageType ?? this.messageType,
      isMe: isMe ?? this.isMe,
    );
  }
}
