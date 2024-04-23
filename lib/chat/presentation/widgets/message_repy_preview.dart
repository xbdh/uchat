import 'package:flutter/material.dart';
import 'package:uchat/chat/domain/entities/last_message_entity.dart';
import 'package:uchat/chat/domain/entities/message_reply_entity.dart';

import '../../../app/enums/enums.dart';

class MessageReplyPreview extends StatelessWidget {
  final MessageReplyEntity MessageReply;
  //final MessageType type;
  //final bool isMe;

  const MessageReplyPreview({super.key, required this.MessageReply});

  @override
  Widget build(BuildContext context) {
    Widget lastMessageToShow() {
      switch (MessageReply.messageType) {
        case MessageType.text:
          return Text(
            MessageReply.message,
            style: const TextStyle(
              //color: color,
              fontSize: 16.0,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case MessageType.image:
          return const Row(
            children: [
              Text("Image "),
              Icon(Icons.image_outlined),
            ],
          );
        case MessageType.video:
          return const Row(
              children: [
                Text("Video "),
                Icon(Icons.video_collection_outlined ),
              ]
          );
        case MessageType.audio:
          return const Row(
            children: [
              Text("Audio "),
              Icon(Icons.audiotrack_outlined),
            ],
          );
        case MessageType.file:
          return const Row(
            children: [
              Text("File "),
              Icon(Icons.insert_drive_file_outlined),
            ],
          );
        default:
          return Text(
            MessageReply.message,
            style: const TextStyle(
              //color: color,
              fontSize: 16.0,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
      }
    }

    return lastMessageToShow();
  }
}