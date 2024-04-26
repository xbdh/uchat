import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/app/widgets/user_avatar.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uuid/uuid.dart';

import '../entities/group_entity.dart';
import '../entities/last_message_entity.dart';
import '../entities/message_entity.dart';
import '../entities/message_reply_entity.dart';
import '../repositories/message_repositories.dart';

class SendTextMessageUseCase {
  final MessageRepository repository;

  SendTextMessageUseCase({required this.repository});

  Future<void> call ({
    required UserEntity sender,
    required MessageReplyEntity? messageReply,
    required String recipientUID,
    required String recipientName,
    required String recipientImage,
    required String message,
    required MessageType messageType,
    required String? groupID,

  }) async {

    var messageId=const Uuid().v4();
   //  // check if it is a message reply
   //  String repliedMessage = messageReply != null ? messageReply.message : '';
   //  String repliedTo = messageReply == null
   //          ? ''
   //          : messageReply.isMe
   //            ? 'You'
   //            : messageReply.senderName;
   // MessageType repliedMessageType = messageReply?.messageType ?? MessageType.text;

    String repliedMessage;
    String repliedTo;
    MessageType repliedMessageType;

    if (messageReply != null) {
      repliedMessage = messageReply.message;
      if (messageReply.isMe) {
        repliedTo = 'You';
      } else {
        repliedTo = messageReply.senderName;
      }
      repliedMessageType = messageReply.messageType;
    } else {
      repliedMessage = '';
      repliedTo = '';
      repliedMessageType = MessageType.text;
    }

    final senderMessageEntity = MessageEntity(
        // fill all
        senderUID: sender.uid,
        senderName: sender.name,
        senderImage: sender.image,
        recipientUID: recipientUID,
        message: message,
        messageType: messageType,
        timeSent: DateTime.now(),
        messageId: messageId,
        isSeen: false,
        repliedMessage: repliedMessage,
        repliedTo: repliedTo,
        repliedMessageType: repliedMessageType,
        reactions: [],
        isSeenBy: [sender.uid],
        deletedBy: []
    );

    final recipientMessageEntity = senderMessageEntity.copyWith(
        recipientUID: senderMessageEntity.senderUID,
    );

    if (groupID != null) {
      await repository.sendGroupMessage(
          senderUID: sender.uid,
          recipientUID: recipientUID,
          messageID: messageId,
          messageEntity: senderMessageEntity
      );

      final lastGroupMessage =GroupEntity(
        creatorUID: "",
        groupName : "",
        groupDescription : "",
        groupImage: '',
        groupId : '',
        lastMessage: message,
        senderUID: sender.uid,
        messageType: messageType,
        messageId :'',
        timeSent:  DateTime.now(),
        createdAt : DateTime.now(),
        isPrivate: false,
        editSettings: false,
        approveMembers: false,
        lockMessages: false,
        requestToJoin: false,
        membersUIDs: [],
        adminsUIDs: [],
        awaitingApprovalUIDs: [],
      );

      await repository.sendGroupLastMessage(
          senderUID: sender.uid,
          recipientUID: recipientUID,
          groupEntity: lastGroupMessage
      );
      return;
    }


    final senderLastMessage = LastMessageEntity(
        senderUID: senderMessageEntity.senderUID,
        recipientUID: recipientUID,
        recipientName: recipientName,
        recipientImage: recipientImage,
        message: senderMessageEntity.message,
        messageType: senderMessageEntity.messageType,
        timeSent: senderMessageEntity.timeSent,
        isSeen: false,

    );

    final recipientLastMessage = senderLastMessage.copyWith(
        recipientUID: senderMessageEntity.senderUID,
        recipientName: senderMessageEntity.senderName,
        recipientImage: senderMessageEntity.senderImage,
    );

    await repository.sendMessage(
        senderUID: senderMessageEntity.senderUID,
        recipientUID: recipientUID,
        messageID: messageId,
        messageEntity: senderMessageEntity
    );
    await repository.sendLastMessage(
        senderUID: senderMessageEntity.senderUID,
        recipientUID: recipientUID,
        lastMessageEntity: senderLastMessage
    );

    await repository.sendMessage(
        senderUID: recipientUID,
        recipientUID: senderMessageEntity.senderUID,
        messageID: messageId,
        messageEntity: recipientMessageEntity
    );

    await repository.sendLastMessage(
        senderUID: recipientUID,
        recipientUID: senderMessageEntity.senderUID,
        lastMessageEntity: recipientLastMessage
    );


    // to do
  }
}