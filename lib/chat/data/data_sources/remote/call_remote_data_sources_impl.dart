import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../main.dart';
import 'call_remote_data_sources.dart';
import 'call_remote_data_sources_impl.dart';

class CallRemoteDataSourceImpl  extends CallRemoteDataSource{
  final Dio dio;
  final FirebaseMessaging messaging;
  CallRemoteDataSourceImpl({required this.dio, required this.messaging});

  @override
  Future<String> getRtcToken(String channelName) async {
    final res=await dio.post(
      'api/get_rtc_token',
      queryParameters: {
        'channelName': channelName,
      },
    );

    logger.i('getRtcToken: ${res.data}');
    return res.data['data']['token'];

  }

  @override
  Future<void> sendNotification(String friendUid,
      String friendFcmToken,
      String friendName,
      String friendImage,
      String callType
      ) async {
    // message structure

    // POST https://fcm.googleapis.com/v1/projects/myproject-b5ae1/messages:send HTTP/1.1
    //
    // Content-Type: application/json
    // Authorization: Bearer ya29.ElqKBGN2Ri_Uz...HnS_uNreA
    //
    // {
    // "message":{
    // "token":"bk3RNwTe3H0:CI2k_HHwgIpoDKCIZvvDMExUdFQ3P1...",
    // "notification":{
    // "body":"This is an FCM notification message!",
    // "title":"FCM Message"
    // }
    // }
    // }
    logger.i('++++sendNotification : $friendFcmToken');
    try {
     // final apiKey = 'AIzaSyBZri8a7WVg7vHs6HDgOz8CzJyaptPkjQw';
      final resp= await dio.post(
        'send_notification',
        options: Options(
            headers: {
              'Content-Type': 'application/json',
              //'Authorization': 'Bearer $apiKey',
            }),
        queryParameters: {
          'uid': friendUid,
          'fcm_token': friendFcmToken,
          'name': friendName,
          'image': friendImage,
          'call_type': callType,

        },
      );
    }catch(e){
      logger.e('sendNotification: $e');
    }

    //logger.i('sendNotification: ${resp.data}');

  }

}