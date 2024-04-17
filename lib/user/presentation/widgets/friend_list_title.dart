import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/app/utils/methods.dart';
import 'package:uchat/app/widgets/user_avatar.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/presentation/cubit/friend_request/friend_request_cubit.dart';

import '../cubit/uid/uid_cubit.dart';
import 'package:uchat/main_injection_container.dart' as di;

class FriendListTitle extends StatefulWidget {
  final FriendViewType viewType;
  final UserEntity friend;

  const FriendListTitle(
      {super.key, required this.viewType, required this.friend});

  @override
  State<FriendListTitle> createState() => _FriendListTitleState();
}

class _FriendListTitleState extends State<FriendListTitle> {
   bool accepted = false;

  @override
  Widget build(BuildContext context) {
    final uid = context.watch<UidCubit>().state;
    return BlocListener<FriendRequestCubit, FriendRequestState>(
      listener: (context, state) {
        if (state is FriendRequestAccepted) {
          //context.pop();
          setState(() {
            accepted = true;
          });
          showSnackBar(
            context: context,
            message: 'You are now friends with ${widget.friend.name}',
          );
        }
      },
      child: ListTile(
          minLeadingWidth: 0,
          contentPadding: const EdgeInsets.only(left: -10),
          title: Text(widget.friend.name),
          subtitle: Text(
            widget.friend.aboutMe,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          leading: UserAvatar(
            imageUrl: widget.friend.image,
            radius: 40,
            onPressed: () {},
          ),
          trailing: widget.viewType == FriendViewType.friendRequests
              ? ElevatedButton(
                // if accepted is true, the button will be null
                onPressed: accepted
                    ? null
                    : () {
                        BlocProvider.of<FriendRequestCubit>(context)
                            .acceptFriendRequest(
                          myUID: uid,
                          friendUID: widget.friend.uid,
                        );
                      },
               // if accepted is true, the text will be Accepted

                  child: accepted ?const Text('Accepted'):const Text('Accept'),
                )
              : null,
          onTap: () {
            if (widget.viewType == FriendViewType.friends) {
              // Navigator.of(context).pushNamed(
              //   OtherProfilePage.routeName,
              //   arguments: friend.uid,
              // );
            }
          }),
    );
    return const Placeholder();
  }
}
