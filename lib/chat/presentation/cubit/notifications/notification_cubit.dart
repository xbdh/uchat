import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:uchat/main.dart';

import '../../../../user/domain/use_cases/user/get_fcm_token_usecase.dart';
import '../../../domain/use_cases/send_notifications_usecase.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  SendNotificationsUseCase sendNotificationUseCase;
  GetFcmTokenUseCase getFcmTokenUseCase;
  NotificationCubit({
    required this.sendNotificationUseCase,
    required this.getFcmTokenUseCase,
  }
      ) : super(NotificationInitial());

  Future<void> sendNotification(
      String uid,
      String friendUid,
      String friendName,
      String friendImage,
      String callType
      ) async {
    emit(NotificationLoading());
    try {
      final friendFcmToken = await getFcmTokenUseCase.call(friendUid);
      logger.i('friendFcmToken: $friendFcmToken');
      await sendNotificationUseCase.call(uid, friendFcmToken, friendName, friendImage,callType);

      emit(NotificationSuccess());
    } catch (e) {
      emit(NotificationFailed());
    }
  }

  Future<void> receiveNotification2(
      String friendUid,
      String friendName,
      String friendImage,
      String callType
      ) async {
    emit(NotificationLoading());
    try {


      emit(NotificationSuccess());
    } catch (e) {
      emit(NotificationFailed());
    }
  }

  Future<void> receiveNotification(
      RemoteMessage message
      ) async {
    emit(NotificationLoading());
    try {
      if(message.data!=null && message.data["call_type"]!=null) {
        //  ////1. voice 2. video 3. text, 4.cancel
        if (message.data["call_type"]=="voice") {
          //  FirebaseMassagingHandler.flutterLocalNotificationsPlugin.cancelAll();
          var data = message.data;
          var friendUid = data["uid"];
          var friendName = data["name"];
          var  friendImage= data["image"];
          // var doc_id = data["doc_id"]??"";
          // var call_role= data["call_type"];
          if (friendUid != null && friendName != null && friendImage != null) {
            // show snackbar use Bloc provider


            // logger all
            logger.i("${friendName} is calling you");
            logger.i("${friendImage} is calling you");
            logger.i("${friendUid} is calling you");


            emit(NotificationReceiveSuccess(
              friendUid: friendUid,
              friendName: friendName,
              friendImage: friendImage,
              callType: "voice",
            ));


          }

        }else if(message.data["call_type"]=="video"){
          //    FirebaseMassagingHandler.flutterLocalNotificationsPlugin.cancelAll();
          //  ////1. voice 2. video 3. text, 4.cancel
          var data = message.data;
          var friendUid = data["uid"];
          var friendName = data["name"];
          var  friendImage= data["image"];
          var doc_id = data["doc_id"]??"";
          // var call_role= data["call_type"];
          if (friendUid != null && friendName != null && friendImage != null) {
            // ConfigStore.to.isCallVocie = true;
            emit(NotificationReceiveSuccess(
              friendUid: friendUid,
              friendName: friendName,
              friendImage: friendImage,
              callType: "voice",
            ));

          }

        }else if(message.data["call_type"]=="cancel"){
          // FirebaseMassagingHandler.flutterLocalNotificationsPlugin.cancelAll();
          //
          // if(Get.isSnackbarOpen){
          //   Get.closeAllSnackbars();
          // }
          //
          // if(Get.currentRoute.contains(AppRoutes.VoiceCall) || Get.currentRoute.contains(AppRoutes.VideoCall)){
          //   Get.back();
          // }

          // var _prefs = await SharedPreferences.getInstance();
          // await _prefs.setString("CallVocieOrVideo","");

        }



      }


      emit(NotificationSuccess());
    } catch (e) {
      emit(NotificationFailed());
    }
  }

}
