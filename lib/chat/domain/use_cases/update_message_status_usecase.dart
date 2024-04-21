import '../repositories/message_repositories.dart';

class UpdateMessageStatusUseCase {
  final MessageRepository repository;

  UpdateMessageStatusUseCase({required this.repository});

  Future<void> call(String senderUID,
      String recipientUID,
      String messageID) async {

    await repository.setMessageStatus(senderUID: senderUID, recipientUID: recipientUID, messageID: messageID);
}}