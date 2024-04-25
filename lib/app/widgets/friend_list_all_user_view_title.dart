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

class FriendListAllUserViewTitle extends StatelessWidget {
  final UserEntity friend;
  // onTap callback function
  final  Function onTap;

   const FriendListAllUserViewTitle(
      {super.key,
        required this.friend,
        required this.onTap
      });


  @override
  Widget build(BuildContext context) {
    final uid = context.watch<UidCubit>().state;
    return ListTile(
        minLeadingWidth: 0,
        contentPadding: const EdgeInsets.only(left: -10),
        title: Text(friend.name),
        subtitle: Text(
          friend.aboutMe,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: UserAvatar(
          imageUrl: friend.image,
          radius: 40,
          onPressed: () {},
        ),
        onTap: () {
          onTap();
        }
    );
    return const Placeholder();
  }
}
