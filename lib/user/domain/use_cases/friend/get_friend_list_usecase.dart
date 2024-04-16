import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/domain/repositories/user_repositories.dart';

class GetFriendListUseCase {
  final UserRepository repository;

  GetFriendListUseCase({required this.repository});

  Future<List<UserEntity>> call(String uid) async {
    List<UserEntity> ll=await repository.getFriends(uid);
    //print('GetFriendListUseCase: $ll');
    return ll;
  }
}