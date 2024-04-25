import 'package:uchat/chat/domain/entities/message_entity.dart';

import '../repositories/message_repositories.dart';

class GetChatMessageListStreamUseCase {
  final MessageRepository repository;

  GetChatMessageListStreamUseCase({required this.repository});

  Stream<List<MessageEntity>> call(String senderUID, String recipientUID,String? groupID) {
    return repository.getMessageListStream(senderUID: senderUID, recipientUID: recipientUID,groupID: groupID);
  }
}