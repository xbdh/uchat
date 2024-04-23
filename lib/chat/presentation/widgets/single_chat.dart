import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uchat/app/widgets/user_avatar.dart';
import 'package:uchat/chat/domain/entities/last_message_entity.dart';
import 'package:uchat/chat/presentation/widgets/last_message_preview.dart';

import '../../../user/presentation/cubit/uid/uid_cubit.dart';

class SingleChat extends StatelessWidget {
  final LastMessageEntity lastMessage;
  final VoidCallback onTap;
  const SingleChat({super.key, required this.lastMessage, required this.onTap});


  @override
  Widget build(BuildContext context) {
    final uid = context.watch<UidCubit>().state;
    final timeSent = lastMessage.timeSent;
    final dateTime=formatDate(timeSent, [hh, ':', nn,' ', am]);
    return ListTile(
      onTap: onTap,
      leading: UserAvatar(
        imageUrl: lastMessage.recipientImage,
        radius: 40, onPressed: () {},
      ),
      contentPadding: EdgeInsets.zero,
      title: Text(lastMessage.recipientName),
      subtitle: Row(
        children: [
          uid==lastMessage.senderUID
            ? const Text(
              "You: ",
              style: TextStyle(
              fontWeight: FontWeight.bold,),
              )
            : const SizedBox.shrink(),

          LastMessagePreview(lastMessage: lastMessage),
        ],
      ),
      trailing: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(dateTime),
            // lastMessage.isSeen
            //   ? const Icon(Icons.done_all)
            //   : const Icon(Icons.done),
          ],
        ),
      )
    );
  }
}