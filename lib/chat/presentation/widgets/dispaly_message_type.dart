import 'package:flutter/material.dart';

import '../../../app/enums/enums.dart';

class DisplayMessageType extends StatelessWidget {
  final String message;
  final MessageType type;
  final Color color;
  final bool isReply;
  final bool viewOnly;

  const DisplayMessageType({
    Key? key,
    required this.message,
    required this.type,
    required this.color,
    required this.isReply,
    required this.viewOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == MessageType.text
        ? Text(
            message,
            style: TextStyle(
              color: color,
              fontSize: 16,
            ),
          )
        : const SizedBox();
  }
}
