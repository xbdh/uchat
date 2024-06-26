import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uchat/chat/domain/entities/message_entity.dart';
import 'package:uchat/chat/domain/entities/message_reply_entity.dart';
import 'package:uchat/chat/presentation/widgets/message_repy_preview.dart';

import '../cubit/message_reply/message_reply_cubit.dart';

class MessageReplyPreviewSwipe extends StatelessWidget {
  const MessageReplyPreviewSwipe({
    super.key,
    required this.messageReplyEntity,
  });

  final MessageReplyEntity messageReplyEntity;

  @override
  Widget build(BuildContext context) {
    final isMe = messageReplyEntity.isMe;
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        top: 0,
        bottom: 5,

      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
         topRight: Radius.circular(30),

        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  isMe ? 'You' : messageReplyEntity.senderName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
               IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  BlocProvider.of<MessageReplyCubit>(context).clearMessageReply();
                },
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: MessageReplyPreview(MessageReply:  messageReplyEntity),
          )
        ],
      ),
    );
  }
}