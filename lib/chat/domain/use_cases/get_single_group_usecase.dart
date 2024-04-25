import 'package:uchat/chat/domain/entities/group_entity.dart';

import '../repositories/message_repositories.dart';

class GetSingleGroupUseCase {
  final MessageRepository repository;

  GetSingleGroupUseCase({required this.repository});

  Future<GroupEntity> call(String groupId) async {
    return repository.getSingleGroup(groupId);
  }
}