import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uchat/app/widgets/user_avatar.dart';
import 'package:uchat/chat/domain/entities/group_entity.dart';
import 'package:uchat/chat/domain/entities/last_message_entity.dart';
import 'package:uchat/chat/presentation/widgets/last_message_preview.dart';
import 'package:uchat/chat/presentation/widgets/unread_mesasage_counter.dart';

import '../../../user/presentation/cubit/uid/uid_cubit.dart';

class SingleChat extends StatelessWidget {
  final LastMessageEntity? lastMessage;
  final GroupEntity? groupEntity;
  final bool isGroup;
  final VoidCallback onTap;

  const SingleChat({super.key,
    this.groupEntity,
     this.lastMessage,
    required this.onTap,
    required this.isGroup
  });


  @override
  Widget build(BuildContext context) {
    final uid = context.watch<UidCubit>().state;

    final lastMes = lastMessage!=null
        ? lastMessage!.message
        : groupEntity!.lastMessage;

    final senderUID = lastMessage!=null
        ? lastMessage!.senderUID
        : groupEntity!.senderUID;

    final timeSent = lastMessage!=null
        ? lastMessage!.timeSent
        : groupEntity!.timeSent;

    final imageUrl = lastMessage!=null
        ? lastMessage!.recipientImage
        : groupEntity!.groupImage;

    final name = lastMessage!=null
        ? lastMessage!.recipientName
        : groupEntity!.groupName;

    final recipientId = lastMessage!=null
        ? lastMessage!.recipientUID
        : groupEntity!.groupId;

    final mesType = lastMessage!=null
        ? lastMessage!.messageType
        : groupEntity!.messageType;

    final dateTime=formatDate(timeSent, [hh, ':', nn,' ', am]);
    return ListTile(
      onTap: onTap,
      leading: UserAvatar(
        imageUrl: imageUrl,
        radius: 40, onPressed: () {},
      ),
      contentPadding: EdgeInsets.zero,
      title: Text(name),
      subtitle: Row(
        children: [
          uid==senderUID
            ? const Text(
              "You: ",
              style: TextStyle(
              fontWeight: FontWeight.bold,),
              )
            : const SizedBox.shrink(),
          const SizedBox(
            width:5,
          ),

          LastMessagePreview(
            lastMessage: lastMes,
            messageType: mesType,
          ),
        ],
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(dateTime),
            UnReadMessageCounter(
              recipientUID: recipientId,
              isGroup: isGroup,
            )
          ],
        ),
      )
    );
  }
}