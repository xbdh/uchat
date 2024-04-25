import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/app/utils/methods.dart';
import 'package:uchat/app/widgets/user_avatar.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/presentation/cubit/friend_request/friend_request_cubit.dart';

import '../../user/presentation/cubit/uid/uid_cubit.dart';
import 'package:uchat/main_injection_container.dart' as di;

class FriendRequestListTitle extends StatefulWidget {
  final UserEntity friendRequest;

  const FriendRequestListTitle(
      {super.key, required this.friendRequest});

  @override
  State<FriendRequestListTitle> createState() => _FriendRequestListTitleState();
}

class _FriendRequestListTitleState extends State<FriendRequestListTitle> {
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
            message: 'You are now friends with ${widget.friendRequest.name}',
          );
        }
      },
      child: ListTile(
          minLeadingWidth: 0,
          contentPadding: const EdgeInsets.only(left: -10),
          title: Text(widget.friendRequest.name),
          subtitle: Text(
            widget.friendRequest.aboutMe,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          leading: UserAvatar(
            imageUrl: widget.friendRequest.image,
            radius: 40,
            onPressed: () {},
          ),
          trailing: ElevatedButton(
                // if accepted is true, the button will be null
                onPressed: accepted
                    ? null
                    : () {
                        BlocProvider.of<FriendRequestCubit>(context)
                            .acceptFriendRequest(
                          myUID: uid,
                          friendUID: widget.friendRequest.uid,
                        );
                      },
               // if accepted is true, the text will be Accepted

                  child: accepted ?const Text('Accepted'):const Text('Accept'),
                ),
              
          onTap: () {
          }),
    );
    return const Placeholder();
  }
}
