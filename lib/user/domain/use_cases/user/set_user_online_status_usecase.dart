import '../../repositories/user_repositories.dart';

class SetUserOnlineStatusUseCase {
  final UserRepository repository;

  SetUserOnlineStatusUseCase({required this.repository});

  Future<void> call(bool isOnline) async {
    await repository.setUserOnlineStatus(isOnline);
  }
}