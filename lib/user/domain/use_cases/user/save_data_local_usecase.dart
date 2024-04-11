import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/domain/repositories/user_repositories.dart';

class SaveDataLocalUseCase {
  final UserRepository userRepository;

  SaveDataLocalUseCase({required this.userRepository});

  Future<void> call(UserEntity user) async {
    return await userRepository.saveUserDataToLocal(user);
  }
}