import 'package:uchat/user/domain/repositories/user_repositories.dart';

class GetCurrentUidUseCase {
  final UserRepository repository;


  GetCurrentUidUseCase({required this.repository});

  Future<String> call() async {
    return repository.getCurrentUID();
  }
}
