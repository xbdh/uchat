import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/user/presentation/cubit/uid/uid_cubit.dart';
import 'package:uchat/user/presentation/widgets/friends_list.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  Widget build(BuildContext context) {
    final uid = context.watch<UidCubit>().state;
    return  Scaffold(
     appBar: AppBar(
       title: Text("Friends"),
       centerTitle: true,
     ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            CupertinoSearchTextField(
              placeholder: 'Search',
              style: const TextStyle(
                color: Colors.white,
              ),
              onChanged: (value) {
                print(value);
              } ,
            ),
            Expanded(
              child:FriendsList(uid: uid, viewType: FriendViewType.friends  )
            ),
            ]

        ),
      ),
      );
  }
}
