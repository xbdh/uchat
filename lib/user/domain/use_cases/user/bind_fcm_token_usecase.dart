import '../../repositories/user_repositories.dart';

class BindFcmTokenUseCase {
  final UserRepository repository;

  BindFcmTokenUseCase({required this.repository});

  Future<void> call(String uid, String fcmToken) async {
     return await repository.bindFcmToken(uid, fcmToken);
  }
}