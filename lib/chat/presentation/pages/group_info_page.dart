import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/widgets/setting_list_title.dart';
import '../cubit/get_single_group/get_single_group_cubit.dart';
import '../widgets/group_info_details_card.dart';
import 'package:uchat/main_injection_container.dart' as di;

class GroupInfoPage extends StatefulWidget {
  final String groupId;

  const GroupInfoPage({super.key, required this.groupId});

  @override
  State<GroupInfoPage> createState() => _GroupInfoPageState();
}

class _GroupInfoPageState extends State<GroupInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Info"),
      ),
      body: BlocProvider(
        create: (context) => di.sl<GetSingleGroupCubit>()..getSingleGroup( widget.groupId),
        child: BlocBuilder<GetSingleGroupCubit,GetSingleGroupState>(
          builder: (context, state) {

            if (state is GetSingleGroupLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetSingleGroupFailed) {
              return const Center(
                child: Text("Error"),
              );
            }
            if (state is GetSingleGroupLoaded) {
              final groupEntity = state.group;
              final memberLength = groupEntity.membersUIDs.length;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GroupInfoDetailsCard(
                    groupId: widget.groupId,
                    groupEntity: groupEntity,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Status',
                      style: GoogleFonts.openSans(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        SettingsAndStatusListTile(
                          title: 'Members',
                          icon: Icons.people_alt_outlined,
                          iconContainerColor: Colors.deepPurple,
                          number: memberLength,
                          onTap: () {

                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }else{
              return const Center(
                child: Text('Failed to load user'),
              );
            }

          },
        ),
      ),
    );
  }
}