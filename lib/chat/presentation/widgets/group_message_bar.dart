import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uchat/app/widgets/user_avatar.dart';
import 'package:uchat/main_injection_container.dart' as di;

import '../../domain/entities/group_entity.dart';
import '../cubit/get_single_group/get_single_group_cubit.dart';

class GroupMessageBar extends StatefulWidget {
  const GroupMessageBar({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  State<GroupMessageBar> createState() => _GroupMessageBarState();
}

class _GroupMessageBarState extends State<GroupMessageBar> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) =>  di.sl<GetSingleGroupCubit>()..getSingleGroup(widget.groupId),
  child: BlocBuilder<GetSingleGroupCubit,GetSingleGroupState>(
  builder: (context, state) {

    if (state is GetSingleGroupLoaded) {
      final GroupEntity group = state.group;
      return Row(
        children: [
          UserAvatar(
            imageUrl: group.groupImage,
            radius: 20,
            onPressed: () {
            },

          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                group.groupName,
                style: GoogleFonts.openSans(
                    fontSize: 16,
                 ),
              ),
              SizedBox(width: 10,),
              Text(
                group.membersUIDs.length.toString() + ' Members',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      );
    }else if (state is GetSingleGroupLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const Center(
        child: Text('Error'),
      );
    }
  },
),
);
  }
}