import 'dart:io';

import '../repositories/message_repositories.dart';

class StoreFileUseCase {
  final MessageRepository repository;

  StoreFileUseCase({required this.repository});

  Future<String> call(File file,String path) async {
    String url = await repository.storeFile(file: file, filePath: path);
    return url;
  }
}