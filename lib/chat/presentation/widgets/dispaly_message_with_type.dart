import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uchat/chat/presentation/widgets/video_player.dart';

import '../../../app/enums/enums.dart';
import '../../../main.dart';
import 'audio_player.dart';

class DisplayMessageWithType extends StatelessWidget {
  final String message;
  final MessageType type;
  final Color color;
  final bool isReply;
  // final bool viewOnly;

  const DisplayMessageWithType({
    super.key,
    required this.message,
    required this.type,
    required this.color,
    required this.isReply,
    // required this.viewOnly,
  });

  @override
  Widget build(BuildContext context) {
    //logger.i("DisplayMessageWithType: $message");
    Widget messageToShow() {
      switch (type) {
        case MessageType.text:
          return Text(
            message,
            style: TextStyle(
              color: color,
              fontSize: 16.0,
            ),
            //maxLines: maxLines,
            //超过换行
            //overflow: TextOverflow.ellipsis,
          );
        case MessageType.image:
          return isReply
              ? const Icon(Icons.image)
              : CachedNetworkImage(
            width: 200,
            height: 200,
            imageUrl: message,
            fit: BoxFit.cover,
          );
        case MessageType.video:
          return
            VideoPlayerWidget(
            videoUrl: message,
            color: color,
            viewOnly: false,
          );
        case MessageType.audio:
          //return Text(message);
          return AudioPlayerWidget(
            audioUrl: message,
            color: color,
            viewOnly: false,
          );
        default:
          return Text(
            message,
            style: TextStyle(
              color: color,
              fontSize: 16.0,
            ),
            // maxLines: maxLines,
            // overflow: overFlow,
          );
      }
    }

    return messageToShow();
  }
}
