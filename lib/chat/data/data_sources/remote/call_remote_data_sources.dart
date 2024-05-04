abstract class CallRemoteDataSource{

  Future<String> getRtcToken(String channelName);

  Future<void> sendNotification(String friendUid,
      String friendFcmToken,
      String friendName,
      String friendImage,
      String callType
      );

}