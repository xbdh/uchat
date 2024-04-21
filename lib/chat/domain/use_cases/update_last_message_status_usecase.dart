import '../repositories/message_repositories.dart';

class UpdateLastMessageStatusUseCase {
  final MessageRepository repository;

  UpdateLastMessageStatusUseCase({required this.repository});

  Future<void> call(String senderUID,
                    String recipientUID,) async{
    await repository.setLastMessageStatus(senderUID: senderUID, recipientUID: recipientUID);

  }
}