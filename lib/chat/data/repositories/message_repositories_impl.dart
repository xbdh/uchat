import 'dart:io';

import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/chat/data/data_sources/remote/message_remote_date_sources.dart';
import 'package:uchat/chat/domain/entities/last_message_entity.dart';
import 'package:uchat/chat/domain/entities/message_entity.dart';
import 'package:uchat/chat/domain/repositories/message_repositories.dart';
import 'package:uchat/user/data/models/user_model.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';

import '../models/last_message_model.dart';
import '../models/message_model.dart';

class MessageRepositoryImpl extends MessageRepository {
  final MessageRemoteDataSource messageDataSource;

  MessageRepositoryImpl({required this.messageDataSource});

  @override
  Stream<List<MessageEntity>> getMessageListStream({
    required String senderUID,
    required String recipientUID,}){

    final Stream<List<MessageModel>> messageModelStream = messageDataSource.getMessageListStream(
      senderUID: senderUID,
      recipientUID: recipientUID
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
  Future<void> setMessageStatus({required String senderUID, required String recipientUID, required String messageID}) async {
    await messageDataSource.setMessageStatus(
      senderUID: senderUID,
      recipientUID: recipientUID,
      messageID: messageID
    );
  }

  @override
  Future<void> setLastMessageStatus({required String senderUID, required String recipientUID}) async  {
    await messageDataSource.setLastMessageStatus(
      senderUID: senderUID,
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
}