import 'package:flutter/material.dart';
import 'package:uchat/chat/domain/entities/message_entity.dart';

import 'chat_swipe_to.dart';

class SingleChatMessage extends StatelessWidget {
  final MessageEntity message;
  final bool isMe;
  final bool isGroupChat;
  //final Function onLeftSwipe;

  const SingleChatMessage({
    super.key,
    required this.message,
    required this.isMe,
    required this.isGroupChat,
   // required this.onLeftSwipe
  });

  @override
  Widget build(BuildContext context) {
    return ChatSwipeTo(
      //onSwipeLeft: onLeftSwipe,
      isMe: isMe,
      messageEntity: message,
      isGroupChat: isGroupChat,
    );
    // return Container(
    //   child: Text(message.message),
    // );
  }
}
