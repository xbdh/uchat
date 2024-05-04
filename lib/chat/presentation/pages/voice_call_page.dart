import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uchat/app/constants/agora.dart';

import '../../../main.dart';

class VoiceCallPage extends StatefulWidget {
  final String friendUid, friendName, friendImage;
  const VoiceCallPage({super.key,
    required this.friendUid,
    required this.friendName,
    required this.friendImage,

  });


  @override
  State<VoiceCallPage> createState() => _VoiceCallPageState();
}

class _VoiceCallPageState extends State<VoiceCallPage> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  // 初始化应用
  Future<void> initAgora() async {
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
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          logger.i("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          logger.i("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          logger.i("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
    // 加入频道，设置用户角色为主播
    await _engine.joinChannel(
      token: '007eJxTYPAU2z8t2mLRvzmc37PEVWacdOVICZNvkjivs4JlWnnOri4FhlQTo9QUE+M0c9PEZBOTZIOkREtDU0ODRAOjJGMzk5Tkh5FGaQ2BjAwljTUMjFAI4nMxlCZnJJbEVySlZDAwAABtFB/V',
      channelId: 'uchat_xbdh',
      options: const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster),
      uid: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel(); // 离开频道
    await _engine.release(); // 释放资源
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
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
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Image.network(
                            widget.friendImage,
                            fit: BoxFit.fill,
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

                                  borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                                ),
                                child: Image.asset(
                                    "assets/icons/b_microphone.png")
                            ),
                            onTap: null,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "Microphone",
                              style: TextStyle(
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
                            child: _localUserJoined ?
                                   Image.asset("assets/icons/a_phone.png")
                                 : Image.asset("assets/icons/a_telephone.png"),
                          ),
                          onTap:(){},
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            _localUserJoined ? "Connected":"Disconnect",
                            style: TextStyle(
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

                              borderRadius:
                              BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Image.asset("assets/icons/bo_trumpet.png")
                          ),
                          onTap:  null,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Speakerphone",
                            style: TextStyle(
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
    );
  }
}