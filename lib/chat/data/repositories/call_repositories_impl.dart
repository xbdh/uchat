import 'package:uchat/chat/data/data_sources/local/local_data_sources.dart';

import '../../../main.dart';
import '../../domain/repositories/call_repositories.dart';
import '../data_sources/remote/call_remote_data_sources.dart';

class CallRepositoryImpl implements CallRepository {
 final CallRemoteDataSource callDataSource;
 final LocalDataSource localDataSource;
 const CallRepositoryImpl({required this.callDataSource, required this.localDataSource});

  @override
  Future<String> getRtcToken(String channelName) async  {
    final token = await callDataSource.getRtcToken(channelName);
    return token;
  }

  @override
  Future<void> sendNotification(String friendUid,
      String friendFcmToken,
      String friendName,
      String friendImage,
      String callType
      ) async {
    logger.i('+++sendNotification : $friendFcmToken');
    await callDataSource.sendNotification(friendUid, friendFcmToken, friendName, friendImage,callType);
  }

}