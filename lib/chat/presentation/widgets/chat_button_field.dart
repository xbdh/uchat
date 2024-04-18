import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uchat/chat/presentation/cubit/message_reply/message_reply_cubit.dart';
import 'package:uchat/chat/presentation/cubit/send_text_message/send_text_message_cubit.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';

import '../../../app/enums/enums.dart';
import '../../../user/presentation/cubit/my_entity/my_entity_cubit.dart';
import '../../domain/entities/message_reply_entity.dart';

class ChatBottomField extends StatefulWidget {
  final String friendUid, friendName, friendImage;
  const ChatBottomField({super.key, required this.friendUid, required this.friendName, required this.friendImage});

  @override
  State<ChatBottomField> createState() => _ChatBottomFieldState();
}

class _ChatBottomFieldState extends State<ChatBottomField> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  @override
  void initState() {
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }
  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
  //
  // void sendTextMessage() {
  //
  //
  // }
  
  @override
  Widget build(BuildContext context) {
    final myEntity = context.watch<MyEntityCubit>().state!;
    final messageReplay = context.watch<MessageReplyCubit>().state ;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {

              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: 200,
                    color: Theme.of(context).cardColor,
                    child: const Center(
                      child: Text('Attachment'),
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.attachment),
          ),
          Expanded(
            child: TextField(
              controller: _textEditingController,
              focusNode: _focusNode,
              decoration: InputDecoration.collapsed(
                hintText: 'Type a message',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<SendTextMessageCubit>(context).sendTextMessage(
                sender: myEntity,
                messageReply: messageReplay,
                recipientUID: widget.friendUid,
                recipientName: widget.friendName,
                recipientImage: widget.friendImage,
                message: _textEditingController.text,
                messageType: MessageType.text,
              );
            },
            child : Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              margin: const EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(Icons.arrow_upward, color: Colors.white),
              ),

            ),
          ),
        ],
      ),
    );
  }
}
