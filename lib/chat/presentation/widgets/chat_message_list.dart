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

import '../../../main.dart';
import '../../../user/presentation/cubit/uid/uid_cubit.dart';
import '../cubit/chat_list_steam/chat_list_stream_cubit.dart';
import 'package:uchat/main_injection_container.dart' as di;

import '../cubit/chat_message_list_steam/chat_message_list_stream_cubit.dart';
import '../cubit/message_reply/message_reply_cubit.dart';
class ChatMessageList extends StatefulWidget {
  final String friendUid;
  final String? groupID;

  const ChatMessageList({super.key, required this.friendUid, required this.groupID});

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
      await Future.delayed(const Duration(milliseconds: 200));
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
      create: (context) => di.sl<ChatMessageListStreamCubit>()..getChatMessageListStream(senderUID: uid, recipientUID: widget.friendUid,groupID: widget.groupID),
      child: GestureDetector(
        onVerticalDragDown: (_) {
          FocusScope.of(context).unfocus();
        },
        child: BlocBuilder<ChatMessageListStreamCubit, ChatMessageListStreamState>(

          builder: (context, state) {
            if (state is ChatMessageListStreamLoaded) {
              final messageLists = state.messageLists;
              if (messageLists.isEmpty) {
                return const Center(
                  child: Text("No Conversations Yet!"),
                );
              }

              //
              // logger.i("messageLists: $messageLists");
              else {

                //auto scroll to bottom
                WidgetsBinding.instance.addPostFrameCallback((_) {
                _scrollToBottom();
                });
              return Container(
                child: GroupedListView<dynamic, DateTime>(

                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  controller: _scrollController,
                  elements: messageLists,
                  reverse: true,
                  groupBy: (element) {
                    return DateTime(
                      element.timeSent.year,
                      element.timeSent.month,
                      element.timeSent.day,
                    );
                  },
                  groupHeaderBuilder: (dynamic messageEntity) {
                    return SizedBox(
                        height: 50,
                        child: ChatDateTime(
                          messageEntity: messageEntity,
                        )
                    );
                  },
                  itemBuilder: (context, dynamic element) {
                    // update seen
                    if (widget.groupID != null) {
                          BlocProvider.of<SetMessageStatusCubit>(context).
                          setMessageStatus(
                              currentUID: uid,
                              recipientUID: widget.friendUid,
                              messageID: element.messageId,
                              isGroup: true,
                              isSeenByList: element.isSeenBy
                          );
                    }else {
                      if (!element.isSeen && element.senderUID != uid) {
                        BlocProvider.of<SetMessageStatusCubit>(context).
                        setMessageStatus(
                            currentUID: uid,
                            recipientUID: widget.friendUid,
                            messageID: element.messageId,
                            isGroup: false,
                            isSeenByList: element.isSeenBy
                        );
                      }
                    }

                    final msg = element as MessageEntity;

                    final bool isMe = msg.senderUID == uid;
                    return SingleChatMessage(
                      key: ValueKey(element.messageId),
                      message: msg,
                      isMe: isMe,
                      isGroupChat: widget.groupID != null,
                      // onLeftSwipe: (){
                      //     final messageReply=MessageReplyEntity(
                      //         message:element.message,
                      //         senderUID: element.senderUID,
                      //         senderName: element.senderName,
                      //         senderImage: element.senderImage,
                      //         messageType: element.messageType,
                      //         isMe: isMe);
                      //     BlocProvider.of<MessageReplyCubit>(context).setMessageReply(
                      //     messageReply);
                      // }
                    );
                  },
                  groupComparator: (DateTime value1, DateTime value2) =>
                      value1.compareTo(value2),
                  itemComparator: (dynamic element1, dynamic element2) {
                    var time1 = element1.timeSent;
                    var time2 = element2.timeSent;
                    return time1!.compareTo(time2!);
                  },
                  useStickyGroupSeparators: true,
                  floatingHeader: true,
                  order: GroupedListOrder.DESC,
                ),
              );
            }
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
