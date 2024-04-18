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
  Stream<List<LastMessageEntity>> getChatListStream() {
    // TODO: implement getChatListStream
    throw UnimplementedError();
  }

  @override
  Stream<List<MessageEntity>> getMessageStream() {
    // TODO: implement getMessageStream
    throw UnimplementedError();
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
    LastMessageModel lastMessageModel = LastMessageModel.fromEntity(lastMessageEntity);

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
}