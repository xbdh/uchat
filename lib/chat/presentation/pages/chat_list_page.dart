import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uchat/chat/presentation/widgets/chat_list.dart';

import '../../../user/presentation/cubit/uid/uid_cubit.dart';


class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    final uid = context.watch<UidCubit>().state;
    return  Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
              ),
              child: CupertinoSearchTextField(
                placeholder: 'Search',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
                onChanged: (value) {
                  print(value);
                },
              ),
            ),
            Expanded(
              child: ChatList( uid : uid),
            ),

          ],
        )
    );
  }
}
