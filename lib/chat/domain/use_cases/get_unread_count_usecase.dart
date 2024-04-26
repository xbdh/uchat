import 'package:uchat/chat/domain/repositories/message_repositories.dart';
import 'package:uchat/main.dart';

class GetUnreadCountUseCase {
  final MessageRepository repository;

  GetUnreadCountUseCase({required this.repository});

  Stream<int> call(String uid, String recipientUID, bool isGroup)  {
    logger.i('GetUnreadCountUseCase call');
    // log the uid and recipientUID
    logger.i('uid: $uid, recipientUID: $recipientUID');


   if (isGroup) {
     return repository.getGroupUnreadMessageCount(uid: uid, groupID: recipientUID);
  }else {
    return repository.getUnreadMessageCount(uid: uid, recipientUID: recipientUID);
   }
}}