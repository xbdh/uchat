import 'package:flutter/material.dart';
import 'package:uchat/chat/presentation/widgets/group_message_bar.dart';

import '../widgets/chat_message_bar.dart';
import '../widgets/chat_message_buttom_field.dart';
import '../widgets/chat_message_list.dart';

class PrivateGroupPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String groupImage;

  const PrivateGroupPage({super.key,
    required this.groupId,
    required this.groupName,
    required this.groupImage,
  });

  @override
  State<PrivateGroupPage> createState() => _PrivateGroupPageState();
}

class _PrivateGroupPageState extends State<PrivateGroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GroupMessageBar(groupId: widget.groupId),
        actions: <Widget> [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 1) {
                // show group info
              } else {
                // leave group
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text('Group Info'),
              ),
              PopupMenuItem(
                value: 2,
                child: Text('Leave Group'),
              ),

            ],
            icon: Icon(Icons.more_vert),
          )
        ],


      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ChatMessageList(
                friendUid: widget.groupId,
                groupID: widget.groupId,
              ),
            ),
            ChatMessageBottomField(
                friendUid: widget.groupId,
                friendName: widget.groupName,
                friendImage: widget.groupImage,
                groupID:widget. groupId,
            )
          ],
      ),
     )
    );
  }
}