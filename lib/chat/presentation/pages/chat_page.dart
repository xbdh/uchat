import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uchat/chat/presentation/widgets/chat_bar.dart';
import 'package:uchat/chat/presentation/widgets/chat_button_field.dart';

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
        title: ChatBar(friendUid: friendUid),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
         children: [
           Expanded(
             child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Message $index"),
                  );
                },
              ),
             ),
            ChatBottomField(friendUid: friendUid, friendName: friendName, friendImage: friendImage)
         ],
        ),
      ),
    );
  }
}
