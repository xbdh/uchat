import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uchat/chat/presentation/widgets/chat_message_bar.dart';
import 'package:uchat/chat/presentation/widgets/chat_message_buttom_field.dart';
import 'package:uchat/chat/presentation/widgets/chat_message_list.dart';

class ChatPage extends StatefulWidget {
  final String friendUid, friendName, friendImage;

  const ChatPage({super.key, required this.friendUid, required this.friendName, required this.friendImage});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final friendUid = widget.friendUid;
    final friendName = widget.friendName;
    final friendImage = widget.friendImage;

    return Scaffold(
      appBar: AppBar(
        title: ChatMessageBar(friendUid: friendUid),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
         children: [
           Expanded(
             child: ChatMessageList(friendUid: friendUid),
             ),
            ChatMessageBottomField(friendUid: friendUid, friendName: friendName, friendImage: friendImage)
         ],
        ),
      ),
    );
  }
}
