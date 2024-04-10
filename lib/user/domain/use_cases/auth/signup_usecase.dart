import 'package:uchat/user/domain/repositories/user_repositories.dart';

class SignUpUseCase {
  final UserRepository repository;

  SignUpUseCase({required this.repository});

  Future<String> call(String email,String password) async {
    return repository.signupWithEmailandPassword(email, password);
  }

}