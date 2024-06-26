  import 'dart:io';

import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/chat/domain/entities/last_message_entity.dart';
import 'package:uchat/chat/domain/entities/message_entity.dart';
import 'package:uchat/chat/domain/entities/message_reply_entity.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';

import '../entities/group_entity.dart';

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
      required String recipientUID,
      required String? groupID,
    });

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

    Future<void> sendGroupMessage({
      required String senderUID,
      required String recipientUID,
      required String messageID,
      required MessageEntity messageEntity,
    });

    Future<void> sendGroupLastMessage({
      required String senderUID,
      required String recipientUID,
      required GroupEntity groupEntity,
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

    Future<void> createGroup(GroupEntity groupEntity);

    Stream<List<GroupEntity>>getGroupListStream({required String uid,required isPrivate});

    // get single group
    Future<GroupEntity> getSingleGroup(String groupId);

    Stream<int> getUnreadMessageCount({required String uid, required String recipientUID});

    Stream<int> getGroupUnreadMessageCount({required String uid, required String groupID});


}