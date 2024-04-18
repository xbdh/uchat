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

    Stream<List<MessageEntity>> getMessageStream();

    Stream<List<LastMessageEntity>> getChatListStream();

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
  }