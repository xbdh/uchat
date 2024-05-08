import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../main.dart';
import '../../../domain/use_cases/get_rtc_token_usecase.dart';
import 'agora_voice_cubit.dart';

part 'agora_video_state.dart';

class AgoraVideoCubit extends Cubit<AgoraVideoState> {
  final GetRtcTokenUseCase getRtcTokenUseCase;
  AgoraVideoCubit(
  {required this.getRtcTokenUseCase}
      ) : super(AgoraVideoInitial());

   late RtcEngine _engine;
  bool isJoined = false;
  bool openMicrophone = true;
  bool enableSpeakerphone = true;
  bool switchCamera = true;
  String call_time = "00:00";
  String call_time_num = "not connected";
  Set<int> remoteUids = {};
  late String channelName;
  late String channelId;
  // get RtcEngine
  RtcEngine get Engine => _engine;

  Future<void> initAgora(String uid,String friendUid,String role) async {

    logger.i('initAgora++');
    // 获取权限
    await [Permission.microphone, Permission.camera].request();

    // 创建 RtcEngine
    _engine = await createAgoraRtcEngine();
   logger.i('initAgora--');
    // 初始化 RtcEngine，设置频道场景为直播场景
    await _engine.initialize(const RtcEngineContext(
      appId: 'e42ed43f75ac44c0ba91510a02b364dc',
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
    logger.i('initAgora--1');

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onError: (ErrorCodeType code, String message) {
          logger.e("onError: $code ; message:$message");

          emit(AgoraVideoFailed());
        },
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          logger.i("local user ${connection.localUid} joined");
          emit(AgoraVideoLocalJoined());
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          logger.i("remote user $remoteUid joined");
          remoteUids.add(remoteUid);
          emit( AgoraVideoRemoteJoined(
              rUid: remoteUid
            ));

        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          logger.i("remote user $remoteUid left channel");
          remoteUids.remove(remoteUid);
          emit(AgoraVideoRemoteLeft());
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {

          isJoined = false;
          remoteUids.clear();

        },
      ),
    );
    logger.i('initAgora--2');
    await _engine.enableVideo();

    logger.i('initAgora--3');
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    logger.i('initAgora--4');
    // await _engine.setVideoEncoderConfiguration(
    //   VideoEncoderConfiguration(
    //     dimensions: VideoDimensions(width: 640, height: 360),
    //     frameRate: 15,
    //     bitrate: 0,
    //   ),
    // );
    // _engine.setupLocalVideo(
    //
    //
    // );
    // hucvty
    logger.i('initAgora--5');

    // await _engine.setupLocalVideo(
    //   VideoCanvas(
    //     view: localVideoView,
    //     renderMode: VideoRenderMode.Hidden,
    //     uid: 0,
    //   ),
    // );
    try{
      await _engine.startPreview();
    }catch(e){
      logger.e(e);
    }


    logger.i('video is ready');
    emit(AgoraVideoIsReady());
    await joinChannel(uid,friendUid,role);
  }

  Future<void> joinChannel(String uid,String friendUid,String role) async {
    try {
      logger.i('uid from : $uid');
      logger.i('friendUid from : $friendUid');
      logger.i('role from : $role');

      if (role == "anchor") {
        channelName= md5.convert(utf8.encode("${uid}_${friendUid}")).toString();
      } else {
        channelName = md5.convert(utf8.encode("${friendUid}_${uid}")).toString();
      }
      logger.i('channelId from : $channelName');
      DateTime now = DateTime.now();
      // 使用 intl 包格式化时间
      String formattedTime = DateFormat('yyyy-MM-dd HH').format(now);

      channelId =  channelName+"_"+formattedTime;

      final token = await getRtcTokenUseCase(channelId);

       logger.i('token : $token');
       logger.i('channelName : $channelId');


      await _engine.joinChannel(
        token: token,
        channelId: channelId,
        uid: 0,
        options: ChannelMediaOptions(),
      );
      //emit(AgoraLocalJoined());
    } catch (e) {
      logger.e('joinChannel fialed: $e');
      //emit(AgoraFailed());
    }

  }

  Future<void > leaveChannel()async {
    //_engine.leaveChannel();
    await _engine.leaveChannel(); // 离开频道
    await _engine.release();
    await _engine.stopPreview();

  }


  Future<void> switchCameraa() async {
    await _engine.switchCamera();
    switchCamera = !switchCamera;

  }

  Future<void> switchSpeakerphone() async {

  }
}
