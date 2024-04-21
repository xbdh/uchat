import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:uchat/chat/presentation/widgets/align_message_right.dart';

import '../../domain/entities/message_entity.dart';
import 'align_message_left.dart';

class ChatSwipeTo extends StatelessWidget {
  final Function onSwipeLeft;
  final bool isMe;
  final MessageEntity messageEntity;

  const ChatSwipeTo({super.key,
    required this.onSwipeLeft,
    required this.isMe,
    required this.messageEntity,
  });

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onLeftSwipe:(details){
        onSwipeLeft();
      },
      child: isMe
        ? AlignMessageRight(message: messageEntity)
          : AlignMessageLeft(message: messageEntity),
    );
  }
}