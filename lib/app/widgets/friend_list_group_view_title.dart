import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/app/utils/methods.dart';
import 'package:uchat/app/widgets/user_avatar.dart';
import 'package:uchat/chat/presentation/cubit/create_group/create_group_cubit.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/presentation/cubit/friend_request/friend_request_cubit.dart';

import '../../user/presentation/cubit/uid/uid_cubit.dart';
import 'package:uchat/main_injection_container.dart' as di;

class FriendListGroupViewTitle extends StatefulWidget {
  final UserEntity friend;

  const FriendListGroupViewTitle(
      {super.key, required this.friend});

  @override
  State<FriendListGroupViewTitle> createState() => _FriendListGroupViewTitleState();
}

class _FriendListGroupViewTitleState extends State<FriendListGroupViewTitle> {
   bool isChoosed = false;

  @override
  Widget build(BuildContext context) {
    final uid = context.watch<UidCubit>().state;
    return ListTile(
        minLeadingWidth: 0,
        contentPadding: const EdgeInsets.only(left: -10),
        title: Text(widget.friend.name),
        subtitle: Text(
          widget.friend.aboutMe,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: UserAvatar(
          imageUrl: widget.friend.image,
          radius: 40,
          onPressed: () {},
        ),
        trailing: Checkbox(
          value: isChoosed,
          onChanged: (value) {
            if (value == true) {
              setState(() {
                isChoosed = true;
                BlocProvider.of<CreateGroupCubit>(context).addMember(widget.friend.uid);
              });
            } else {
              setState(() {
                isChoosed = false;
                BlocProvider.of<CreateGroupCubit>(context).removeMember(widget.friend.uid);
              });
            }
          },
        ),
        onTap: () {

        });
  }
}
