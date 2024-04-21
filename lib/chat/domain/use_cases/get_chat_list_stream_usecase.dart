import 'package:uchat/chat/domain/entities/last_message_entity.dart';

import '../repositories/message_repositories.dart';

class GetChatListStreamUseCase {
  final MessageRepository repository;


  GetChatListStreamUseCase({required this.repository});

  Stream<List<LastMessageEntity>> call(String uid) {
    return repository.getChatListStream(uid: uid);
  }
}