
import 'package:uchat/user/domain/repositories/user_repositories.dart';
class CheckUserExistsUseCase {
  final UserRepository repository;

  CheckUserExistsUseCase({required this.repository});

  Future<bool> call(String id) async {
    return repository.isSignIn();
  }
}
