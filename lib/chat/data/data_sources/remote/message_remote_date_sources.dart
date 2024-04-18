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

  Stream<List<MessageModel>> getMessageStream();

  Stream<List<LastMessageModel>> getChatListStream();

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
}