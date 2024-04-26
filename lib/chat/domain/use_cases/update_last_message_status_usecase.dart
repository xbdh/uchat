import '../repositories/message_repositories.dart';

class UpdateLastMessageStatusUseCase {
  final MessageRepository repository;

  UpdateLastMessageStatusUseCase({required this.repository});

  Future<void> call(String currentUID,
                    String recipientUID,) async{
    await repository.setLastMessageStatus(currentUID: currentUID, recipientUID: recipientUID);

  }
}