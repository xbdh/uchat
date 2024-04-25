import 'package:uchat/chat/domain/entities/group_entity.dart';

import '../repositories/message_repositories.dart';

class CreateGroupUseCase {
  final MessageRepository repository;

  CreateGroupUseCase({required this.repository});

  Future<void> call(GroupEntity groupEntity) async {
    return repository.createGroup(groupEntity);
  }
}