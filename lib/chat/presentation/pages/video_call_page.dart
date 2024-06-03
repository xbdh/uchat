import 'package:flutter/material.dart';

import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../app/values/colors.dart';
import '../../../main.dart';
import '../../../user/presentation/cubit/uid/uid_cubit.dart';
import '../cubit/agora/agora_video_cubit.dart';
import '../cubit/notifications/notification_cubit.dart';

// 应用类
class VideoCallPage extends StatefulWidget {
  final String friendUid, friendName, friendImage;
  final String role;
  const VideoCallPage(
      {super.key,
      required this.friendUid,
      required this.friendName,
      required this.friendImage,
      required this.role});
  @override
  _VideoCallPageState createState() => _VideoCallPageState();
}

// 应用状态类
class _VideoCallPageState extends State<VideoCallPage> {
  //int? _remoteUid; // 用于存储远端用户的 uid
  bool _localUserJoined = false; // 表示本地用户是否加入频道，初始值为 false
  late RtcEngine _engine;
  bool isJoined = false, switchCamera = true, switchRender = true;
  final player = AudioPlayer();
  Timer? _timer;
  int _seconds = 0; // 用于存储 RtcEngine 实例
  int? remoteUid;
  bool isReady = false;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  @override
  void initState() {
    super.initState();
    final uid = BlocProvider.of<UidCubit>(context).state;
    logger.i("initState init argora video cubit");
    BlocProvider.of<AgoraVideoCubit>(context)
        .initAgora(uid, widget.friendUid, widget.role);

    if (widget.role == "anchor") {
      player.setAsset("assets/music/Sound_Horizon.mp3");
      player.play();
    }
  }

  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<AgoraVideoCubit>(context).leaveChannel();
    player.pause();
    player.dispose();
    stopTimer();
  }

  String formatDuration(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  // 构建 UI，显示本地视图和远端视图
  @override
  Widget build(BuildContext context) {
    final uid = BlocProvider.of<UidCubit>(context).state;
    return BlocListener<AgoraVideoCubit, AgoraVideoState>(
      listener: (context, state) {
        if (state is AgoraVideoIsReady) {
          logger.i("AgoraVideoIsReady");
          setState(() {
            isReady = true;
          });
        }

        if (widget.role == "anchor") {
          if (state is AgoraVideoRemoteJoined) {
            logger.i("AgoraVideoRemoteJoined");
            setState(() {
              remoteUid = state.rUid;
            });
            logger.i("remoteUid: $remoteUid");
            player.pause();
            startTimer();
          }

          if (state is AgoraVideoLocalJoined) {
            logger.i("AgoraVideoLocalJoined");
            setState(() {
              _localUserJoined = true;
            });
            logger.i("localUserJoined: $_localUserJoined");
            BlocProvider.of<NotificationCubit>(context).sendNotification(
                uid, //来自我的uid ，给你sendNotification
                widget.friendUid,
                widget.friendName,
                widget.friendImage,
                "video");
            logger.i("video sendNotification");
          }

          if (state is AgoraVideoRemoteLeft) {
            stopTimer();
            BlocProvider.of<AgoraVideoCubit>(context).leaveChannel();
            // context.goNamed('Chat',
            //     queryParameters: {
            //       'friendUid': widget.friendUid,
            //       'friendName': widget.friendName,
            //       'friendImage': widget.friendImage,
            //       'groupId': '',
            //     });
            context.pop();
          }
        } else {
          if (state is AgoraVideoLocalJoined) {
            setState(() {
              _localUserJoined = true;
            });
            startTimer();
          }
          if (state is AgoraVideoRemoteJoined) {
            logger.i("AgoraVideoRemoteJoined");
            setState(() {
              remoteUid = state.rUid;
            });
            logger.i("remoteUid: $remoteUid");
          }
          if (state is AgoraVideoRemoteLeft) {
            stopTimer();
            BlocProvider.of<AgoraVideoCubit>(context).leaveChannel();
            // context.goNamed('Chat',
            //     queryParameters: {
            //       'friendUid': widget.friendUid,
            //       'friendName': widget.friendName,
            //       'friendImage': widget.friendImage,
            //       'groupId': '',
            //     });
            context.pop();
          }
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Video Call"),
          ),
          //backgroundColor: AppColors.primary_bg,
          body: !isReady
              ? Container()
              : Stack(
                  children: [
                    remoteUid == null
                        ? Container()
                        : AgoraVideoView(
                            controller: VideoViewController.remote(
                              rtcEngine:
                                  BlocProvider.of<AgoraVideoCubit>(context)
                                      .Engine,
                              canvas: VideoCanvas(uid: remoteUid!),
                              connection: RtcConnection(
                                  channelId:
                                      BlocProvider.of<AgoraVideoCubit>(context)
                                          .channelId),
                            ),
                          ),
                    Positioned(
                      top: 30,
                      left: 15,
                      child: SizedBox(
                        width: 80,
                        height: 120,
                        child: AgoraVideoView(
                          controller: VideoViewController(
                            rtcEngine: BlocProvider.of<AgoraVideoCubit>(context)
                                .Engine,
                            canvas: const VideoCanvas(uid: 0),
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //     top: 10,
                    //     left: 30,
                    //     right: 30,
                    //     child:Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Container(
                    //             margin: EdgeInsets.only(top:6.h),
                    //             child: Text("{Time}",
                    //               style: TextStyle(
                    //                 color: AppColors.primaryElementText,
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.normal,
                    //               ),),),
                    //           Container(
                    //             width: 70,
                    //             height: 70,
                    //             margin: EdgeInsets.only(top:150),
                    //             padding: EdgeInsets.all(0),
                    //             decoration: BoxDecoration(
                    //               color: AppColors.primaryElementText,
                    //               borderRadius: BorderRadius.all(Radius.circular(10.w)),
                    //             ),
                    //             child: Image.network("${controller.state.to_avatar.value}",fit: BoxFit.fill,),),
                    //           Container(
                    //             margin: EdgeInsets.only(top:6.h),
                    //             child: Text("${controller.state.to_name.value}",
                    //               style: TextStyle(
                    //                 color: AppColors.primaryElementText,
                    //                 fontSize: 18.sp,
                    //                 fontWeight: FontWeight.normal,
                    //               ),),)
                    //         ])),
                    Positioned(
                        bottom: 80,
                        left: 30,
                        right: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(children: [
                              GestureDetector(
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: _localUserJoined
                                        ? AppColors.primaryElementBg
                                        : AppColors.primaryElementStatus,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                  ),
                                  child: _localUserJoined
                                      ? Image.asset("assets/icons/a_phone.png")
                                      : Image.asset(
                                          "assets/icons/a_telephone.png"),
                                ),
                                onTap: _localUserJoined
                                    ? () {
                                        BlocProvider.of<AgoraVideoCubit>(
                                                context)
                                            .leaveChannel();
                                        context.pop();
                                      }
                                    : () {},
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  _localUserJoined ? "Disconnect" : "Connected",
                                  style: TextStyle(
                                    color: AppColors.primaryElementText,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ]),
                            Column(children: [
                              GestureDetector(
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: switchCamera
                                          ? AppColors.primaryElementText
                                          : AppColors.primaryText,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                    child: switchCamera
                                        ? Image.asset(
                                            "assets/icons/b_photo.png")
                                        : Image.asset(
                                            "assets/icons/a_photo.png"),
                                  ),
                                  onTap: () {
                                    BlocProvider.of<AgoraVideoCubit>(context)
                                        .switchCameraa();
                                    setState(() {
                                      switchCamera = !switchCamera;
                                    });
                                  }),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "switchCamera",
                                  style: TextStyle(
                                    color: AppColors.primaryElementText,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              )
                            ]),
                          ],
                        ))
                  ],
                )),
    );
  }
}

// 生成远端视频
