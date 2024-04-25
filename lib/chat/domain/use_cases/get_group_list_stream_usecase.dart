import 'package:uchat/chat/data/models/group_model.dart';
import 'package:uchat/chat/domain/entities/group_entity.dart';

import '../repositories/message_repositories.dart';

class GetGroupListStreamUseCase {
  final MessageRepository repository;


  GetGroupListStreamUseCase({required this.repository});

  Stream<List<GroupEntity>> call(String uid,bool isPrivate) {
    return repository.getGroupListStream(uid: uid, isPrivate: isPrivate);
  }
}