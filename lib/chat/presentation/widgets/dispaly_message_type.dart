import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../app/enums/enums.dart';

class DisplayMessageType extends StatelessWidget {
  final String message;
  final MessageType type;
  final Color color;
  final bool isReply;
  // final bool viewOnly;

  const DisplayMessageType({
    Key? key,
    required this.message,
    required this.type,
    required this.color,
    required this.isReply,
    // required this.viewOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget messageToShow() {
      switch (type) {
        case MessageType.text:
          return Text(
            message,
            style: TextStyle(
              color: color,
              fontSize: 16.0,
            ),
            // maxLines: maxLines,
            // overflow: overFlow,
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
        // case MessageEnum.video:
        //   return isReply
        //       ? const Icon(Icons.video_collection)
        //       : VideoPlayerWidget(
        //     videoUrl: message,
        //     color: color,
        //     viewOnly: viewOnly,
        //   );
        // case MessageEnum.audio:
        //   return isReply
        //       ? const Icon(Icons.audiotrack)
        //       : AudioPlayerWidget(
        //     audioUrl: message,
        //     color: color,
        //     viewOnly: viewOnly,
        //   );
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
