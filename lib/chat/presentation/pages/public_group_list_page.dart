import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/utils/methods.dart';
import '../../../user/presentation/cubit/uid/uid_cubit.dart';
import '../cubit/group_list_stream/group_list_stream_cubit.dart';
import '../widgets/single_chat.dart';
import 'package:uchat/main_injection_container.dart' as di;

class PublicGroupListPage extends StatelessWidget {
  const PublicGroupListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = context.watch<UidCubit>().state;
    return  BlocProvider(
      create: (context) => di.sl<GroupListStreamCubit>()..getGroupListStream(uid: uid, isPrivate: false),

      child: BlocConsumer<GroupListStreamCubit, GroupListStreamState>(
        listener: (context, state) {
          if (state is GroupListStreamFailed) {
            showSnackBar(context: context, message: "Failed to load groups");
          }
        },
        builder: (context, state) {
          if (state is GroupListStreamLoaded) {
            final groupLists = state.groupLists;
            if (groupLists.isEmpty) {
              return const Center(
                child: Text("No Public Group Yet!"),
              );
            }else {
              return Scaffold(
                  body: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: CupertinoSearchTextField(
                          placeholder: 'Search',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: groupLists.length,
                          itemBuilder: (context, index) {
                            final group = groupLists[index];
                            return SingleChat(
                              groupEntity: group,
                              isGroup: true,
                              onTap: () {
                                context.pushNamed(
                                  "PublicGroup",
                                  queryParameters: {
                                    "groupId": group.groupId,
                                    "groupName": group.groupName,
                                    "groupImage": group.groupImage,
                                  },
                                );
                              },
                            );
                          },
                        ),
                      )

                    ],
                  )
              );

            }
          }else if (state is GroupListStreamFailed) {
            return const Center(
              child: Text("Failed to load groups"),
            );
          }else if (state is GroupListStreamLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else {
            return const SizedBox.shrink();
          }

        },
      ),
    );
  }
}