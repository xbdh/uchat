import 'dart:io';

import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/chat/data/models/last_message_model.dart';
import 'package:uchat/chat/data/models/message_model.dart';
import 'package:uchat/user/data/models/user_model.dart';

abstract class MessageRemoteDataSource {
  Future<void> sendTextMessage({
    required UserModel sender,
    required String recipientUID,
    required String recipientName,
    required String recipientImage,
    required String message,
    required MessageType messageType,
  });

  Future<void> sendFileMessage(MessageModel message);

  Stream<List<MessageModel>> getMessageListStream({
    required String senderUID,
    required String recipientUID,});


  Stream<List<LastMessageModel>> getChatListStream({required String uid});

  Future<void> sendMessage({
    required String senderUID,
    required String recipientUID,
    required String messageID,
    required MessageModel messageModel,
  });

  Future<void> sendLastMessage({
    required String senderUID,
    required String recipientUID,
    required LastMessageModel lastMessageModel,
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