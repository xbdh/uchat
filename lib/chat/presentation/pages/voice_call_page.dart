import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uchat/app/constants/agora.dart';
import 'package:uchat/app/values/values.dart';
import 'package:uchat/user/presentation/cubit/uid/uid_cubit.dart';

import '../../../main.dart';
import '../cubit/agora/agora_cubit.dart';
import '../cubit/notifications/notification_cubit.dart';

class VoiceCallPage extends StatefulWidget {
  final String friendUid, friendName, friendImage;
  final String role;

  //final String uid ;
  const VoiceCallPage({super.key,
    required this.friendUid,
    required this.friendName,
    required this.friendImage,
    required this.role,
    // required this.uid

  });


  @override
  State<VoiceCallPage> createState() => _VoiceCallPageState();
}

class _VoiceCallPageState extends State<VoiceCallPage> {
  late RtcEngine _engine;
  bool _isReadyPreview = false;
  bool openMicrophone = true;
  bool enableSpeakerphone = true;
  bool isJoined = false, switchCamera = true, switchRender = true;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    final uid = BlocProvider
        .of<UidCubit>(context)
        .state;
    BlocProvider.of<AgoraCubit>(context).initAgora(
        uid, widget.friendUid, widget.role
    );

    if (widget.role == "anchor") {
      player.setAsset("assets/music/Sound_Horizon.mp3");
      player.play();
    }
  }
  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<AgoraCubit>(context).leaveChannel();
    player.pause();
    player.dispose();
  }




  @override
  Widget build(BuildContext context) {
    final uid = BlocProvider
        .of<UidCubit>(context)
        .state;
        return BlocListener<AgoraCubit, AgoraState>(
  listener: (context, state) {
    if (widget.role == "anchor") {
      if (state is AgoraLocalJoined){
        BlocProvider.of<NotificationCubit>(context).
        sendNotification(uid, //来自我的uid ，给你sendNotification
            widget.friendUid,
            widget.friendName,
            widget.friendImage,
            "voice");
           logger.i("sendNotification");
           setState(() {
              isJoined = true;
           });
      }

      if (state is AgoraRemoteJoined){
        player.pause();
      }
      if (state is AgoraRemoteLeave) {
         BlocProvider.of<AgoraCubit>(context).leaveChannel();
      }
    }else {
      if (state is AgoraLocalJoined){
        setState(() {
          isJoined = true;
        });
      }
      if (state is AgoraRemoteLeave) {
        BlocProvider.of<AgoraCubit>(context).leaveChannel();
      }
    }
    // TODO: implement listener


  },
  child: Scaffold(
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          body: SafeArea(
            child: Container(
              child: Stack(children: [
                Positioned(
                    top: 10,
                    left: 30,
                    right: 30,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            child: Text(
                              "Time",
                              style: TextStyle(
                                //color: AppColors.primaryElementText,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 70,
                            height: 70,
                            margin: EdgeInsets.only(top: 150),
                            padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              //color: AppColors.primaryElementText,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: widget.friendImage,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            child: Text(
                              widget.friendName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        ])),
                Positioned(
                    bottom: 80,
                    left: 30,
                    right: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                  width: 60,
                                  height: 60,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color :openMicrophone
                                        ? AppColors.primaryElementText
                                        : AppColors.primaryText,
                                    borderRadius:BorderRadius.all(Radius.circular(30)),
                                  ),
                                  child: openMicrophone
                                      ? Image.asset("assets/icons/b_microphone.png")
                                      : Image.asset( "assets/icons/a_microphone.png"),
                              ),
                              onTap:isJoined?
                              () {
                                BlocProvider.of<AgoraCubit>(context).switchMicrophone();
                                setState(() {
                                  openMicrophone = !openMicrophone;
                                });
                              }
                                  : null,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "Microphone",
                                style: TextStyle(
                                  color: AppColors.primaryElementText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(children: [
                          GestureDetector(
                            child: Container(
                              width: 60,
                              height: 60,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(

                                borderRadius:
                                BorderRadius.all(Radius.circular(30)),
                              ),
                              child: isJoined

                              ?Image.asset("assets/icons/a_phone.png")
                                  : Image.asset("assets/icons/a_telephone.png"),
                            ),
                            onTap: isJoined?
                                () {
                              BlocProvider.of<AgoraCubit>(context).leaveChannel();
                              context.goNamed('ChatPage',
                                  queryParameters: {
                                    'friendUid': widget.friendUid,
                                    'friendName': widget.friendName,
                                    'friendImage': widget.friendImage,
                                  });

                                }: () {

                              BlocProvider.of<AgoraCubit>(context).joinChannel(uid, widget.friendUid, widget.role);
    },
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              isJoined ? "DisConnected" : "Connected",
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
                                  color: enableSpeakerphone
                                      ? AppColors.primaryElementText
                                      : AppColors.primaryText,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                                ),
                                child: enableSpeakerphone?
                                Image.asset(
                                    "assets/icons/bo_trumpet.png")
                                    : Image.asset("assets/icons/a_trumpet.png")
                            ),
                            onTap: isJoined?
                            () {
                             BlocProvider.of<AgoraCubit>(context).switchSpeakerphone();
                              setState(() {
                                enableSpeakerphone = !enableSpeakerphone;
                              });
                            }
                                : null,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "Speakerphone",
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
              ]),

            ),
          ),
        ),
);
  }
}