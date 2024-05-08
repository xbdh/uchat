import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uchat/app/utils/methods.dart';
import 'package:uchat/chat/presentation/widgets/single_chat.dart';
import 'package:uchat/main_injection_container.dart' as di;
import '../cubit/chat_list_steam/chat_list_stream_cubit.dart';

class ChatList extends StatefulWidget {
  final String uid;
  final bool isGroup;

  const ChatList({super.key, required this.uid,required this.isGroup});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  void initState() {
    // BlocProvider.of<ChatListStreamCubit>(context).getChatListStream(
    //     uid: widget.uid);
    super.initState();
  }
  @override
  void dispose() {
    BlocProvider.of<ChatListStreamCubit>(context).leaveChatListStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<ChatListStreamCubit>()..getChatListStream(
          uid: widget.uid),
      child: BlocConsumer<ChatListStreamCubit, ChatListStreamState>(
        listener: (context, state) {
          if (state is ChatListStreamFailed) {
            showSnackBar(context: context, message: "Failed to load chats");
          }
        },
        builder: (context, state) {
          if (state is ChatListStreamLoaded) {
            final chatLists = state.chatLists;
            if (chatLists.isEmpty) {
              return const Center(
                child: Text("No Chats Yet!"),
              );
            }
            return ListView.builder(
              itemCount: chatLists.length,
              itemBuilder: (context, index) {
                final chat = chatLists[index];
                return SingleChat(
                  lastMessage: chat,
                  isGroup: false,
                  onTap: () {
                    context.pushNamed(
                      "Chat",
                      queryParameters: {
                        "friendUid": chat.recipientUID,
                        "friendName": chat.recipientName,
                        "friendImage": chat.recipientImage,
                        "groupId": "",
                      },
                    );
                  },
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
