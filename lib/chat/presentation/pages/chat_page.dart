import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uchat/chat/presentation/widgets/chat_message_bar.dart';
import 'package:uchat/chat/presentation/widgets/chat_message_buttom_field.dart';
import 'package:uchat/chat/presentation/widgets/chat_message_list.dart';
import 'package:uchat/chat/presentation/widgets/group_message_bar.dart';
import 'package:uchat/chat/presentation/widgets/group_popup_menu_button.dart';
import 'package:uchat/main.dart';
import 'package:uchat/user/presentation/cubit/uid/uid_cubit.dart';

import '../../../user/presentation/cubit/user/user_cubit.dart';
import '../cubit/notifications/notification_cubit.dart';

class ChatPage extends StatefulWidget {
  final String friendUid, friendName, friendImage;
  final String groupId;

  const ChatPage({
    super.key,
    required this.friendUid,
    required this.friendName,
    required this.friendImage,
    required this.groupId,

  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final friendUid = widget.friendUid;
    final friendName = widget.friendName;
    final friendImage = widget.friendImage;
    bool isGroup = widget.groupId.isNotEmpty;

    final uid = BlocProvider.of<UidCubit>(context).state;
    //final friendFcmToken = BlocProvider.of<UserCubit>(context).getFcmToken(friendUid);

   // logger.i('friendFcmToken: $friendFcmToken');
    return Scaffold(
      appBar: AppBar(
        title: isGroup
            ? GroupMessageBar(groupId: friendUid)
            : ChatMessageBar(friendUid: friendUid),
        actions: isGroup
            ? [
                GroupPopupMenuButton(
                  groupId: friendUid,
                )
              ]
            : <Widget>[
              Row(
                children: [
                  // IconButton(
                  //   icon: const Icon(Icons.video_call),
                  //   onPressed: () {
                  //     context.goNamed('VideoCall',
                  //       queryParameters: {
                  //         'friendUid': friendUid,
                  //         'friendName': friendName,
                  //         'friendImage': friendImage,
                  //         'friendFcmToken': friendFcmToken,
                  //       },
                  //     );
                  //   },
                  // ),
                  IconButton(
                    icon: const Icon(Icons.call),
                    onPressed: () {
                      context.pushNamed('VoiceCall',
                        queryParameters: {
                          'friendUid': friendUid,
                          'friendName': friendName,
                          'friendImage': friendImage,
                          'role': 'anchor',
                          //'friendFcmToken': friendFcmToken,
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.videocam),
                    onPressed: () {
                      logger.i('video call pressed');
                      context.pushNamed('VideoCall',
                        queryParameters: {
                          'friendUid': friendUid,
                          'friendName': friendName,
                          'friendImage': friendImage,
                          'role': 'anchor',
                          //'friendFcmToken': friendFcmToken,
                        },
                      );
                    },
                  ),
                ],
              )

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ChatMessageList(
                friendUid: friendUid,
                groupID: isGroup ? friendUid : null,
              ),
            ),
            ChatMessageBottomField(
              friendUid: friendUid,
              friendName: friendName,
              friendImage: friendImage,
              groupID: isGroup ? friendUid : null,
            )
          ],
        ),
      ),
    );
  }
}
