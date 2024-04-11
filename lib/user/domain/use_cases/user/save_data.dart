
import 'dart:io';

import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/domain/repositories/user_repositories.dart';

class SavaDataUseCase {
  final UserRepository userRepository;

  SavaDataUseCase({required this.userRepository});

  Future<UserEntity> call(UserEntity user,File? fileAvatar) async {
    late String imageUrl;
    final uid=user.uid;
    if(fileAvatar!=null){
      imageUrl=await userRepository.storeFileToRemote(fileAvatar, uid);
    }
    // change user avatar url
    String lastSeen=DateTime.now().microsecondsSinceEpoch.toString();
    String createdAt=DateTime.now().microsecondsSinceEpoch.toString();
    UserEntity u=user.copyWith(image: imageUrl,lastSeen: lastSeen,createdAt: createdAt);


    await userRepository.saveUserDataToRemote(u);

    await userRepository.saveUserDataToLocal(u);
    return u;
  }
}