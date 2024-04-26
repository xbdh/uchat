import '../repositories/message_repositories.dart';

class UpdateMessageStatusUseCase {
  final MessageRepository repository;

  UpdateMessageStatusUseCase({required this.repository});

  Future<void> call(
      String currentUID,
      String recipientUID,
      String messageID) async {

    await repository.setMessageStatus(currentUID: currentUID, recipientUID: recipientUID, messageID: messageID);
}}