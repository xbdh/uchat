import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uchat/app/constants/agora.dart';
import 'package:uchat/user/presentation/cubit/uid/uid_cubit.dart';

import '../../../main.dart';
import '../cubit/agora/agora_cubit.dart';

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
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    final uid = BlocProvider
        .of<UidCubit>(context)
        .state;
    BlocProvider.of<AgoraCubit>(context).initAgora(
        uid, widget.friendUid, widget.role
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgoraCubit, AgoraState>(
      listener: (context, state) {
        if (state is AgoraLocalUserJoined) {
          logger.i("local user joined");
          _localUserJoined = true;
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
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
                            onTap: () {},
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              _localUserJoined ? "Connected" : "Disconnect",
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
                                child: Image.asset(
                                    "assets/icons/bo_trumpet.png")
                            ),
                            onTap: null,
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
      },
    );
  }
}