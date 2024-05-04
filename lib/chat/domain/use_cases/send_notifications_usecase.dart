import '../../../main.dart';
import '../repositories/call_repositories.dart';

class SendNotificationsUseCase {
  final CallRepository repository;

  SendNotificationsUseCase({required this.repository});

  Future<void> call(String friendUid,
      String friendFcmToken,
      String friendName,
      String friendImage,
      String callType
      ) async {
    logger.i('+++sendNotification : $friendFcmToken');
     await repository.sendNotification(friendUid, friendFcmToken, friendName, friendImage,callType);
  }
}