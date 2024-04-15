import 'package:uchat/user/domain/repositories/user_repositories.dart';

class SendFriendRequestUseCase {
  final UserRepository repository;

  SendFriendRequestUseCase({required this.repository});

  Future<void> call(String friendUID,String myUID) async {
    await repository.sendFriendRequest(friendUID, myUID);
  }
}