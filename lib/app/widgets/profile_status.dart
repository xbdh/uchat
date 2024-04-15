import 'package:flutter/material.dart';
import 'package:uchat/app/widgets/friend_button.dart';
import 'package:uchat/app/widgets/friend_request_button.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';

class ProfileStatus extends StatelessWidget {
  final String currentUid;
  final UserEntity userEntity;

  const ProfileStatus({super.key,
    required this.currentUid,
    required this.userEntity});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        FriendRequestButton(),
        SizedBox(width: 10),
        FriendButton(),
      ],
    );
  }
}