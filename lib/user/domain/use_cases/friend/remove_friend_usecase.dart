import 'package:uchat/user/domain/repositories/user_repositories.dart';

class RemoveFriendUseCase {
  final UserRepository repository;

  RemoveFriendUseCase({required this.repository});

  Future<void> call(String friendUID,String myUID) async {
    await repository.removeFriend(friendUID, myUID);
  }
}