import 'dart:io';

import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/chat/data/data_sources/remote/message_remote_date_sources.dart';
import 'package:uchat/chat/domain/entities/group_entity.dart';
import 'package:uchat/chat/domain/entities/last_message_entity.dart';
import 'package:uchat/chat/domain/entities/message_entity.dart';
import 'package:uchat/chat/domain/repositories/message_repositories.dart';
import 'package:uchat/user/data/models/user_model.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';

import '../data_sources/local/local_data_sources.dart';
import '../models/group_model.dart';
import '../models/last_message_model.dart';
import '../models/message_model.dart';

class MessageRepositoryImpl extends MessageRepository {
  final MessageRemoteDataSource messageDataSource;


  MessageRepositoryImpl({required this.messageDataSource,
  });

  @override
  Stream<List<MessageEntity>> getMessageListStream({
    required String senderUID,
    required String recipientUID,
    required String? groupID,
  }){

    final Stream<List<MessageModel>> messageModelStream = messageDataSource.getMessageListStream(
      senderUID: senderUID,
      recipientUID: recipientUID,
groupID: groupID
    );
    // convert MessageModel to MessageEntity
    return messageModelStream.map((messageModelList) {
      return messageModelList.map((e) => MessageEntity.fromMessageModel(e)).toList();
    });

  }

  @override
  Stream<List<LastMessageEntity>> getChatListStream({required String uid}){
    final Stream<List<LastMessageModel>> lastMessageModelStream = messageDataSource.getChatListStream(uid: uid);
    // convert LastMessageModel to LastMessageEntity
    return lastMessageModelStream.map((lastMessageModelList) {
      return lastMessageModelList.map((e) => LastMessageEntity.fromLastMessageModel(e)).toList();
    });
  }


  @override
  Future<void> sendFileMessage(MessageEntity message) {
    // TODO: implement sendFileMessage
    throw UnimplementedError();
  }

  @override
  Future<void> sendTextMessage({required UserEntity sender, required String recipientUID, required String recipientName, required String recipientImage, required String message, required MessageType messageType}) {
    // TODO: implement sendTextMessage
    throw UnimplementedError();
  }

  @override
  Future<void> sendLastMessage({
    required String senderUID,
    required String recipientUID,
    required LastMessageEntity lastMessageEntity})  async {
   // convert LastMessageEntity to LastMessageModel
    LastMessageModel lastMessageModel = LastMessageModel.fromLastMessageEntity(lastMessageEntity);

    await  messageDataSource.sendLastMessage(
      senderUID: senderUID,
      recipientUID: recipientUID,
      lastMessageModel: lastMessageModel
    );
  }

  @override
  Future<void> sendMessage({required String senderUID,
    required String recipientUID,
    required String messageID,
    required MessageEntity messageEntity}) async  {
    MessageModel messageModel = MessageModel.fromEntity(messageEntity);

    await messageDataSource.sendMessage(
      senderUID: senderUID,
      recipientUID: recipientUID,
      messageID: messageID,
      messageModel: messageModel
    );

  }

  @override
  Future<void> setMessageStatus({required String currentUID, required String recipientUID, required String messageID}) async {
    await messageDataSource.setMessageStatus(
      currentUID: currentUID,
      recipientUID: recipientUID,
      messageID: messageID
    );
  }
  @override
  Future<void> setGroupMessageStatus({required String currentUID, required String recipientUID, required String messageID}) async {
    await messageDataSource.setGroupMessageStatus(
        currentUID: currentUID,
        recipientUID: recipientUID,
        messageID: messageID
    );
  }

  @override
  Future<void> setLastMessageStatus({required String currentUID, required String recipientUID}) async  {
    await messageDataSource.setLastMessageStatus(
      currentUID: currentUID,
      recipientUID: recipientUID
    );
  }

  @override
  Future<String> storeFile({required File file, required String filePath})  async{
   String url =await messageDataSource.storeFile(
      file: file,
      filePath: filePath
    );
    return url;
  }

  @override
  Future<void> createGroup(GroupEntity groupEntity) async {
    // convert GroupEntity to GroupModel
    GroupModel groupModel = GroupModel.fromGroupEntity(groupEntity);
    await messageDataSource.createGroup(groupModel);

  }

  @override
  Stream<List<GroupEntity>> getGroupListStream({required String uid, required isPrivate}) {
    return messageDataSource.getGroupListStream(uid: uid, isPrivate: isPrivate).map((groupModelList) {
      return groupModelList.map((e) => GroupEntity.fromGroupModel(e)).toList();
    });
  }

  @override
  Future<GroupEntity> getSingleGroup(String groupId) async {
    final groupModel = await messageDataSource.getSingleGroup(groupId);
    return GroupEntity.fromGroupModel(groupModel);
  }

  @override
  Future<void> sendGroupLastMessage({
    required String senderUID,
    required String recipientUID,
    required GroupEntity groupEntity}) async {
    // convert GroupEntity to GroupModel
    GroupModel groupModel = GroupModel.fromGroupEntity(groupEntity);
    await messageDataSource.sendGroupLastMessage(
      senderUID: senderUID,
      recipientUID: recipientUID,
      groupModel: groupModel
    );
  }

  @override
  Future<void> sendGroupMessage({
    required String senderUID,
    required String recipientUID,
    required String messageID,
    required MessageEntity messageEntity}) async {
    // convert MessageEntity to MessageModel
    MessageModel messageModel = MessageModel.fromEntity(messageEntity);
    await messageDataSource.sendGroupMessage(
      senderUID: senderUID,
      recipientUID: recipientUID,
      messageID: messageID,
      messageModel: messageModel
    );
  }

  @override
  Stream<int> getGroupUnreadMessageCount({required String uid, required String groupID}) {
    return messageDataSource.getGroupUnreadMessageCount(uid: uid, groupID: groupID);
  }

  @override
  Stream<int> getUnreadMessageCount({required String uid, required String recipientUID}) {
    return messageDataSource.getUnreadMessageCount(uid: uid, recipientUID: recipientUID);
  }
}