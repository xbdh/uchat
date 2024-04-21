import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart';
import 'package:uchat/app/widgets/user_avatar.dart';
import 'package:uchat/main_injection_container.dart' as di;
import 'package:uchat/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import 'package:uchat/user/presentation/cubit/uid/uid_cubit.dart';

class ChatMessageBar extends StatefulWidget {
  final String friendUid;

  const ChatMessageBar({super.key, required this.friendUid});

  @override
  State<ChatMessageBar> createState() => _ChatMessageBarState();
}

class _ChatMessageBarState extends State<ChatMessageBar> {
  @override
  Widget build(BuildContext context) {
    final uid = context.watch<UidCubit>().state;
    return BlocProvider(
      create: (context) => di.sl<GetSingleUserCubit>()..getSingleUser(uid: widget.friendUid),
      child: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, state) {
          if (state is GetSingleUserLoaded) {
            final friend = state.singleUser;

            DateTime lastSeen =DateTime.fromMillisecondsSinceEpoch(int.parse(friend.lastSeen));
           // print('lastSeen: $lastSeen');
            return Row(
                children: [
                  UserAvatar(
                    imageUrl: friend.image,
                    radius: 20,
                    onPressed: () {
                      context.pushNamed(
                        "OtherProfile",
                        queryParameters: {
                          "uid": friend.uid,
                          "loginUid": uid,
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          friend.name,
                          style: GoogleFonts.openSans(
                          fontSize: 16,
                        ),

                      ),
                      Text(
                        friend.isOnline
                            ? 'Online'
                            : "Last seen ${format(lastSeen)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: friend.isOnline
                              ? Colors.green
                              : Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
