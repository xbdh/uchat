import 'package:flutter/material.dart';
import 'package:uchat/chat/domain/entities/last_message_entity.dart';

import '../../../app/enums/enums.dart';

class LastMessagePreview extends StatelessWidget {
  final LastMessageEntity lastMessage;
  //final MessageType type;
  //final bool isMe;

  const LastMessagePreview({super.key, required this.lastMessage});

  @override
  Widget build(BuildContext context) {
    Widget lastMessageToShow() {
      switch (lastMessage.messageType) {
        case MessageType.text:
          return Expanded(
            child: Text(
              lastMessage.message,
              style: const TextStyle(
                //color: color,
                fontSize: 16.0,
              ),
               maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
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
            lastMessage.message,
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