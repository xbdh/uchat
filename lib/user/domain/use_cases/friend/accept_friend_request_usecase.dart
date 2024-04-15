import 'package:uchat/user/domain/repositories/user_repositories.dart';

class AcceptFriendRequestUseCase {
  final UserRepository repository;

  AcceptFriendRequestUseCase({required this.repository});

  Future<void> call(String friendUID,String myUID) async {
    await repository.acceptFriendRequest(friendUID, myUID);
  }
}
