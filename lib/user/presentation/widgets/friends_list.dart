import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/presentation/cubit/friend_list/friend_list_cubit.dart';
import 'package:uchat/user/presentation/cubit/friend_request/friend_request_cubit.dart';
import 'package:uchat/user/presentation/cubit/friend_request/friend_request_cubit.dart';
import 'package:uchat/user/presentation/cubit/user/user_cubit.dart';
import 'package:uchat/main_injection_container.dart' as di;
import 'package:uchat/user/presentation/widgets/friend_list_title.dart';

import '../cubit/friend_request/friend_request_cubit.dart';

class FriendsList extends StatelessWidget {
  final String uid;
  final FriendViewType viewType;

  const FriendsList({super.key, required this.uid, required this.viewType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        if(viewType == FriendViewType.friends){
          return di.sl<FriendListCubit>()..getFriendList( myUID: uid);
        }else{
          return di.sl<FriendListCubit>()..getFriendRequestList(myUID: uid );
        }
      },

      child: BlocBuilder<FriendListCubit, FriendListState>(
        builder: (context, friendRequestState) {
          if (viewType == FriendViewType.friends) {
            if (friendRequestState is FriendListLoaded) {
              final friends = friendRequestState.friends;
              if (friends.isEmpty) {
                return const Center(
                  child: Text(
                    'No friends found',
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: friends.length,
                  itemBuilder: (context, index) {
                    final friend = friendRequestState.friends[index];
                    return FriendListTitle(
                      viewType: viewType,
                      friend: friend,
                    );
                  },
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            if (friendRequestState is FriendListLoaded) {
              final friendRequests = friendRequestState.friends;
              if (friendRequests.isEmpty) {
                return const Center(
                  child: Text(
                    'No friend requests found',
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: friendRequests.length,
                  itemBuilder: (context, index) {
                    final friendRequest =friendRequests[index];
                    return FriendListTitle(
                      viewType: viewType,
                      friend: friendRequest,
                    );
                  },
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        }
      ),
    );
  }
}
