import '../../repositories/user_repositories.dart';

class GetFcmTokenUseCase {
  final UserRepository repository;

  GetFcmTokenUseCase({required this.repository});

  Future<String> call(String uid) async {
    return await repository.getFcmToken(uid);
  }
}