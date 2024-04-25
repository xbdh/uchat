import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uchat/app/widgets/user_avatar.dart';
import 'package:uchat/user/presentation/cubit/uid/uid_cubit.dart';
import 'package:uchat/user/presentation/cubit/user/user_cubit.dart';

import '../../../app/widgets/friend_list_all_user_view_title.dart';

class PeoplePage extends StatefulWidget {
  // final String uid;
  const PeoplePage({super.key});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getAllUser(false);
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = context.watch<UidCubit>().state;
    //final uid1 = context.read<UidCubit>().state;
    return Scaffold(
        //appBar: AppBar(),
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CupertinoSearchTextField(
                  placeholder: 'Search',
                ),
              ),
              Expanded(
                child: BlocBuilder<UserCubit, UserState>(
                    builder: (context, getUserState) {
                  if (getUserState is GetUsersExpectMeLoaded) {
                    final users = getUserState.allUser;
                    if (users.isEmpty) {
                      return  Center(
                        child: Text(
                            'No people found',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            )

                        ),
                      );
                    } else {
                      print("users.lengthddd+++ ${users}");
                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return FriendListAllUserViewTitle(
                            friend: users[index],
                            onTap: () {

                              context.pushNamed(
                                "OtherProfile",
                                 queryParameters: {
                                  "uid": users[index].uid,
                                  "loginUid": uid,
                                },
                              );
                            },
                          );
                        },
                      );
                    }
                  } else if (getUserState is UserLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }else if (getUserState is UserGetAllUsersFail) {
                    return const Text("people page fuck");
                  }else {
                    return const Text("people page fuck2");
                  }

                }),
              )
            ],
          ),
        ));
  }
}
