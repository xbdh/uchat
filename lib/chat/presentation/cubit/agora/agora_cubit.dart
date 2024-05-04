import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../main.dart';
import '../../../domain/use_cases/get_rtc_token_usecase.dart';

part 'agora_state.dart';

class AgoraCubit extends Cubit<AgoraState> {
  final GetRtcTokenUseCase getRtcTokenUseCase;
  AgoraCubit(
    {required this.getRtcTokenUseCase}
      ) : super(AgoraInitial());
  late RtcEngine _engine;

  void initAgora() async {
    // 获取权限
    await [Permission.microphone].request();

    // 创建 RtcEngine
    _engine = await createAgoraRtcEngine();

    // 初始化 RtcEngine，设置频道场景为直播场景
    await _engine.initialize(const RtcEngineContext(
      appId: 'e42ed43f75ac44c0ba91510a02b364dc',
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onError: (ErrorCodeType code, String message) {
          logger.e("onError: $code ; message:$message");
          emit(AgoraFailed());
        },
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          logger.i("local user ${connection.localUid} joined");
          emit(AgoraLocalUserJoined());
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          logger.i("remote user $remoteUid joined");
          emit(AgoraRemoteUserJoined());
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          logger.i("remote user $remoteUid left channel");
          emit(AgoraRemoteUserLeft());
        },
      ),
    );
  }

  void joinChannel(String uid,String friendUid,String role) async {
    late String channelId;
    if (role == "anchor") {
      channelId= md5.convert(utf8.encode("${uid}_${friendUid}")).toString();
    } else {
      channelId = md5.convert(utf8.encode("${friendUid}_${uid}")).toString();
    }
    final token = await getRtcTokenUseCase(channelId);

    await _engine.joinChannel(
      token: token,
      channelId: channelId,
      uid: 0,
      options: ChannelMediaOptions(),
    );
  }

  void leaveChannel() {
    _engine.leaveChannel();

  }
}
