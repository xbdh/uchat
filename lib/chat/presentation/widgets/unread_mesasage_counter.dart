import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uchat/chat/presentation/cubit/get_unread_count/get_unread_count_cubit.dart';
 import 'package:uchat/main_injection_container.dart' as di;

import '../../../main.dart';
import '../../../user/presentation/cubit/uid/uid_cubit.dart';

class UnReadMessageCounter extends StatefulWidget {
  final String recipientUID;
  final bool isGroup;

  const UnReadMessageCounter({
    super.key,
    required this.recipientUID,
    required this.isGroup,
  });

  @override
  State<UnReadMessageCounter> createState() => _UnReadMessageCounterState();
}

class _UnReadMessageCounterState extends State<UnReadMessageCounter> {
  @override
  Widget build(BuildContext context) {
    final uid = context.watch<UidCubit>().state;
    return BlocProvider(
      create: (context) => di.sl<GetUnreadCountCubit>()..getUnreadCount(uid: uid, recipientUID: widget.recipientUID, isGroup: widget.isGroup),
      child: BlocBuilder<GetUnreadCountCubit, GetUnreadCountState>(
        builder: (context, state) {
          if (state is GetUnreadCountLoaded) {
            int unreadMessages = state.count;
            logger.i('Unread Messages+++: $unreadMessages');
            if (unreadMessages == 0) {
              return SizedBox();
            }
            return Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1,
                      blurRadius: 6.0,
                      offset: Offset(0, 1),
                    ),
                  ]),
              child: Text(
                unreadMessages.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            );
          }else if (state is GetUnreadCountFailed) {
            return SizedBox();
          }else {
            return SizedBox();
          }

        },
      ),
    );
  }
}