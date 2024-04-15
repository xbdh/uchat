import 'package:uchat/user/domain/repositories/user_repositories.dart';

class CancleFriendRequestUseCase {
  final UserRepository repository;

  CancleFriendRequestUseCase({required this.repository});

  Future<void> call(String friendUID,String myUID) async {
    await repository.cancelFriendRequest(friendUID, myUID);
  }
}