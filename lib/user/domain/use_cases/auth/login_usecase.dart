import 'package:uchat/user/domain/repositories/user_repositories.dart';

class LogInUseCase {
  final UserRepository repository;

  LogInUseCase({required this.repository});

  Future<String> call(String email,String password) async {
    return repository.logInWithEmailandPassword(email, password);
  }

}