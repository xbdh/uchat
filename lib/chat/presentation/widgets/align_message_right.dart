import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/chat/domain/entities/message_entity.dart';

import 'dispaly_message_type.dart';

class AlignMessageRight extends StatelessWidget {
  const AlignMessageRight({
    super.key,
    required this.message,
    // this.viewOnly = false,
    // required this.isGroupChat,
  });

  final MessageEntity message;
  // final bool viewOnly;
  // final bool isGroupChat;

  @override
  Widget build(BuildContext context) {
    final time = formatDate(message.timeSent, [hh, ':', nn, ' ', am]);
    final isReplying = message.repliedTo.isNotEmpty;
    // get the reations from the list
    final messageReations =
    message.reactions.map((e) => e.split('=')[1]).toList();
    final padding = message.reactions.isNotEmpty
        ? const EdgeInsets.only(left: 20.0, bottom: 25.0)
        : const EdgeInsets.only(bottom: 0.0);

    // bool messageSeen() {
    //   final uid = context.read<AuthenticationProvider>().userModel!.uid;
    //   bool isSeen = false;
    //   if (isGroupChat) {
    //     List<String> isSeenByList = message.isSeenBy;
    //     if (isSeenByList.contains(uid)) {
    //       // remove our uid then check again
    //       isSeenByList.remove(uid);
    //     }
    //     isSeen = isSeenByList.isNotEmpty ? true : false;
    //   } else {
    //     isSeen = message.isSeen ? true : false;
    //   }
    //
    //   return isSeen;
    // }

    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
          //minWidth: MediaQuery.of(context).size.width * 0.3,
        ),
        child: Stack(
          children: [
            Padding(
              padding: padding,
              child: Card(
                elevation: 5,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                color: Colors.deepPurple,
                child: Padding(
                  padding: message.messageType == MessageType.text
                      ? const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0)
                      : const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isReplying) ...[
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.repliedTo,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  message.repliedMessage,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                        DisplayMessageType(
                          message: message.message,
                          type: message.messageType,
                          color: Colors.white,
                          isReply: false,
                          //viewOnly: viewOnly,
                        ),
                        // Text(
                        //   message.message,
                        //   style: const TextStyle(
                        //     fontSize: 16,
                        //   ),
                        // ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          //mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              time,
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              message.isSeen ? Icons.done_all : Icons.done,
                              color:
                              message.isSeen ? Colors.blue : Colors.white60,
                              size: 15,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Positioned(
            //   bottom: 4,
            //   right: 30,
            //   child: StackedReactions(
            //     reactions: messageReations,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
