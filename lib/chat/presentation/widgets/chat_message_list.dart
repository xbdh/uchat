import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:uchat/chat/domain/entities/message_entity.dart';
import 'package:uchat/chat/domain/entities/message_reply_entity.dart';
import 'package:uchat/chat/presentation/cubit/set_message_status/set_message_status_cubit.dart';
import 'package:uchat/chat/presentation/widgets/chat_data_time.dart';
import 'package:uchat/chat/presentation/widgets/single_chat_message.dart';

import '../../../user/presentation/cubit/uid/uid_cubit.dart';
import '../cubit/chat_list_steam/chat_list_stream_cubit.dart';
import 'package:uchat/main_injection_container.dart' as di;

import '../cubit/chat_message_list_steam/chat_message_list_stream_cubit.dart';
import '../cubit/message_reply/message_reply_cubit.dart';
class ChatMessageList extends StatefulWidget {
  final String friendUid;

  const ChatMessageList({super.key, required this.friendUid});

  @override
  State<ChatMessageList> createState() => _ChatMessageListState();
}

class _ChatMessageListState extends State<ChatMessageList> {
  // scrollController
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();

  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  Future<void> _scrollToBottom() async {
    if (_scrollController.hasClients) {
      await Future.delayed(const Duration(milliseconds: 100));
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = context
        .watch<UidCubit>()
        .state;

    return BlocProvider(
      create: (context) => di.sl<ChatMessageListStreamCubit>()..getChatMessageListStream(senderUID: uid, recipientUID: widget.friendUid),
      child: GestureDetector(
        onVerticalDragDown: (_) {
          FocusScope.of(context).unfocus();
        },
        child: BlocConsumer<ChatMessageListStreamCubit, ChatMessageListStreamState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is ChatMessageListStreamLoaded) {
              final messageLists = state.messageLists;
              if (messageLists.isEmpty) {
                return const Center(
                  child: Text("No Conversations Yet!"),
                );
              }

              // auto scroll to bottom
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _scrollToBottom();
              });
              return GroupedListView<MessageEntity,DateTime>(
                controller: _scrollController,
                elements: messageLists,
                reverse: true,
                groupBy: (element)  {
                  return DateTime(
                    element.timeSent.year,
                    element.timeSent.month,
                    element.timeSent.day,
                  );
                },
                groupHeaderBuilder: (MessageEntity messageEntity) {
                  return SizedBox(
                    height: 50,
                    child: ChatDateTime(
                      messageEntity: messageEntity,
                    )
                  );
                },
                itemBuilder: (context, element) {
                  // update seen
                  if (!element.isSeen&&element.senderUID != uid) {
                    BlocProvider.of<SetMessageStatusCubit>(context).
                    setMessageStatus(
                        senderUID: element.senderUID,
                        recipientUID: uid,
                        messageID: element.messageId
                    );
                  }

                  final bool isMe = element.senderUID == uid;
                  return SingleChatMessage(
                      message: element,
                      isMe: isMe,
                      onLeftSwipe: (){
                          final messageReply=MessageReplyEntity(
                              message:element.message,
                              senderUID: element.senderUID,
                              senderName: element.senderName,
                              senderImage: element.senderImage,
                              messageType: element.messageType,
                              isMe: isMe);
                          BlocProvider.of<MessageReplyCubit>(context).setMessageReply(
                          messageReply);
                      }
                      );
                },
                groupComparator: (DateTime value1, DateTime value2) => value1.compareTo(value2),
                itemComparator: (MessageEntity element1, MessageEntity element2) => element1.timeSent.compareTo(element2.timeSent),
                useStickyGroupSeparators: true,
                floatingHeader: true,
                order: GroupedListOrder.DESC,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

          },
        ),
      ),
    );
  }
}
