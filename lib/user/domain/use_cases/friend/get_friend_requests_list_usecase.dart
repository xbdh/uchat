import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/domain/repositories/user_repositories.dart';

class GetFriendRequestListUseCase {
  final UserRepository repository;

  GetFriendRequestListUseCase({required this.repository});

  Future<List<UserEntity>> call(String uid) async {
    List<UserEntity> ll=await repository.getFriendRequests(uid);
    return ll;
  }
}