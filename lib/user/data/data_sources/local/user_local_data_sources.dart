
import 'package:uchat/user/data/models/user_model.dart';

abstract class UserLocalDataSource {
  // Future<void> saveUserDataToFirestore(UserModel user);
  Future<void> savaUserDataToLocal(UserModel user);
  Future<UserModel?> getUserDataFromLocal();
}