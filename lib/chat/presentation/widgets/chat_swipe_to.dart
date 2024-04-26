import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:uchat/chat/presentation/widgets/align_message_right.dart';

import '../../../main.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/entities/message_reply_entity.dart';
import '../cubit/message_reply/message_reply_cubit.dart';
import 'align_message_left.dart';

class ChatSwipeTo extends StatelessWidget {
  //final Function onSwipeLeft;
  final bool isMe;
  final MessageEntity messageEntity;
  final bool isGroupChat;
  const ChatSwipeTo({super.key,
    //required this.onSwipeLeft,
    required this.isMe,
    required this.messageEntity,
    required this.isGroupChat,
  });

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onLeftSwipe:(details)  {
       // details.
        logger.i('Swiped Left $details');
        logger.i('Swiped Left $messageEntity');
        final messageReply=MessageReplyEntity(
            message:messageEntity.message,
            senderUID: messageEntity.senderUID,
            senderName: messageEntity.senderName,
            senderImage: messageEntity.senderImage,
            messageType: messageEntity.messageType,
            isMe: isMe);
       BlocProvider.of<MessageReplyCubit>(context).setMessageReply(
            messageReply);
        //onSwipeLeft();
      },
      child: isMe
        ? AlignMessageRight(message: messageEntity, isGroupChat: isGroupChat)
          : AlignMessageLeft(message: messageEntity, isGroupChat: isGroupChat),
    );
  }
}