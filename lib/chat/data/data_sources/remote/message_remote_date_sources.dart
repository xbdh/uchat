import 'dart:io';

import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/chat/data/models/group_model.dart';
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
    required String recipientUID,
    required String? groupID,
  });


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
    required String currentUID,
    required String recipientUID,
    required String messageID,
  });
  Future<void> setGroupMessageStatus({
    required String currentUID,
    required String recipientUID,
    required String messageID,
  });

  Future<void> setLastMessageStatus({
    required String currentUID,
    required String recipientUID,
    //required String messageID,
  });

  Future<String> storeFile({
    required File file,
    required String filePath,
  });
  Future<void> createGroup(GroupModel groupModel);

  Stream<List<GroupModel>> getGroupListStream({required String uid, required isPrivate});

  Future<GroupModel> getSingleGroup(String groupId);


  Future<void> sendGroupMessage({
    required String senderUID,
    required String recipientUID,
    required String messageID,
    required MessageModel messageModel,
  });

  Future<void> sendGroupLastMessage({
    required String senderUID,
    required String recipientUID,
    required GroupModel groupModel,
  });

  Stream<int> getUnreadMessageCount({required String uid, required String recipientUID});

  Stream<int> getGroupUnreadMessageCount({required String uid, required String groupID});

}