import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/app/widgets/user_avatar.dart';
import 'package:uchat/chat/presentation/widgets/message_reply_preview_swipe.dart';

import '../../domain/entities/message_entity.dart';
import 'dispaly_message_with_type.dart';

class AlignMessageLeft extends StatelessWidget {
  final MessageEntity message;
  const AlignMessageLeft({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
   // return Text(message.message);
    final time = formatDate(message.timeSent, [hh, ':', nn, ' ', am]);
    final isReplying = message.repliedTo.isNotEmpty;
    // get the reations from the list
    final messageReations =
    message.reactions.map((e) => e.split('=')[1]).toList();
    // check if its dark mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final padding = message.reactions.isNotEmpty
        ? const EdgeInsets.only(right: 20.0, bottom: 25.0)
        : const EdgeInsets.only(bottom: 0.0);
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
          minWidth: MediaQuery.of(context).size.width * 0.3,
        ),
        child: Row(
           // 底部对其
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // if (isGroupChat)
            //   Padding(
            //     padding: const EdgeInsets.only(right: 5),
            //     child: userImageWidget(
            //       imageUrl: message.senderImage,
            //       radius: 20,
            //       onTap: () {},
            //     ),
            //   ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 5),
            //   child: UserAvatar(
            //     imageUrl: message.senderImage,
            //     radius: 20,
            //     onPressed: () {},
            //   ),
            // ),
            Expanded(
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
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      color: Theme.of(context).cardColor,
                      child: Padding(
                        padding: message.messageType == MessageType.text
                            ? const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0)
                            : const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 10.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                           // mainAxisSize: MainAxisSize.min,
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
                                          color: Colors.black,
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
                              DisplayMessageWithType(
                                message: message.message,
                                type: message.messageType,
                                color:  isDarkMode ? Colors.white : Colors.black,
                                isReply: false,
                                //viewOnly: viewOnly,
                              ),
                              // Text(
                              //   message.message,
                              //   style: const TextStyle(
                              //     fontSize: 16,
                              //   ),
                              //   // maxLines: 10,
                              //   // overflow: TextOverflow.ellipsis,
                              // ),
                              Text(
                                time,
                                style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white60
                                        : Colors.grey.shade500,
                                    fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
