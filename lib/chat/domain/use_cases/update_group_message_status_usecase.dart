import '../repositories/message_repositories.dart';

class UpdateGroupMessageStatusUseCase {
  final MessageRepository repository;

  UpdateGroupMessageStatusUseCase({required this.repository});

  Future<void> call(
      String currentUID,
      String recipientUID,
      String messageID) async {

    await repository.setGroupMessageStatus(currentUID: currentUID, recipientUID: recipientUID, messageID: messageID);
  }}