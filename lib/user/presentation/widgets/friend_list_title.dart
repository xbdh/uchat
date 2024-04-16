import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/app/widgets/user_avatar.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/presentation/cubit/friend_request/friend_request_cubit.dart';

import '../cubit/uid/uid_cubit.dart';

class FriendListTitle extends StatelessWidget {
  final FriendViewType viewType;
  final UserEntity friend;
  const FriendListTitle({super.key, required this.viewType, required this.friend});

  @override
  Widget build(BuildContext context) {
    final uid = context.watch<UidCubit>().state;
    return ListTile(
      minLeadingWidth: 0,
      contentPadding: const EdgeInsets.only(left:-10),
      title: Text(friend.name),
      subtitle: Text(
          friend.aboutMe,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      leading: UserAvatar(
        imageUrl: friend.image,
        radius:40,
        onPressed: () {}  ,
      ),
      trailing: viewType == FriendViewType.friendRequests
          ? ElevatedButton(
              onPressed: () {
                BlocProvider.of<FriendRequestCubit>(context)
                    .acceptFriendRequest(
                  myUID: uid,
                  friendUID: friend.uid,
                );
              },
              child: const Text('Accept'),
            )
          : null,

      onTap: () {
        if (viewType == FriendViewType.friends) {
          // Navigator.of(context).pushNamed(
          //   OtherProfilePage.routeName,
          //   arguments: friend.uid,
          // );
        }
      }
    );
    return const Placeholder();
  }
}
