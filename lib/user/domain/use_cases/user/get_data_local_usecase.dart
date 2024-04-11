import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/domain/repositories/user_repositories.dart';

class GetDataLocalUseCase {
  final UserRepository repository;

  GetDataLocalUseCase({required this.repository});

  Future<UserEntity?> call() async {
     UserEntity? userEntity=await repository.getUserDataFromLocal();
      return userEntity;
  }
}