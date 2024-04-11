import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/domain/repositories/user_repositories.dart';

class GetDataRemoteUseCase {
  final UserRepository userRepository;

  GetDataRemoteUseCase({required this.userRepository});

  Future<UserEntity?> call(String uid) async {
    UserEntity? User=await userRepository.getUserDataFromRemote(uid);
    return User;
  }
}