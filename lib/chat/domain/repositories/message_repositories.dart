  import 'dart:io';

import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/chat/domain/entities/last_message_entity.dart';
import 'package:uchat/chat/domain/entities/message_entity.dart';
import 'package:uchat/chat/domain/entities/message_reply_entity.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';

abstract class MessageRepository {
    Future<void> sendTextMessage({
      required UserEntity sender,
      required String recipientUID,
      required String recipientName,
      required String recipientImage,
      required String message,
      required MessageType messageType,
    }) ;

    Future<void> sendFileMessage(MessageEntity message);

    Stream<List<MessageEntity>> getMessageListStream({
      required String senderUID,
      required String recipientUID,});

    Stream<List<LastMessageEntity>> getChatListStream({required String uid});

    Future<void> sendMessage({
      required String senderUID,
      required String recipientUID,
      required String messageID,
      required MessageEntity messageEntity,
    });

    Future<void> sendLastMessage({
      required String senderUID,
      required String recipientUID,
      required LastMessageEntity lastMessageEntity,
    });


    Future<void> setMessageStatus({
      required String senderUID,
      required String recipientUID,
      required String messageID,
    });
    Future<void> setLastMessageStatus({
      required String senderUID,
      required String recipientUID,
      //required String messageID,
    });

    Future<String> storeFile({
      required File file,
      required String filePath,
    });

  }