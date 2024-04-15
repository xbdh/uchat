import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uchat/app/widgets/user_avatar.dart';
import 'package:uchat/user/presentation/cubit/get_user/get_user_cubit.dart';
import 'package:uchat/user/presentation/cubit/uid/uid_cubit.dart';

class PeoplePage extends StatefulWidget {
  // final String uid;
  const PeoplePage({super.key});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  @override
  void initState() {
    BlocProvider.of<GetUserCubit>(context).getAllUser(false);
    super.initState();
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
                child: BlocBuilder<GetUserCubit, GetUserState>(
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
                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(users[index].name),
                            subtitle: Text(users[index].aboutMe),
                            leading: UserAvatar(
                              imageUrl: users[index].image,
                              radius: 40,
                              onPressed: () {},
                            ),
                            onTap: () {

                              context.pushNamed(
                                "Profile",
                                pathParameters: {
                                  'uid': users[index].uid,
                                  'loginUid': uid
                                },
                              );
                            },
                          );
                        },
                      );
                    }
                  } else if (getUserState is GetUserLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }else{
                    return const SizedBox.shrink();
                  }

                }),
              )
            ],
          ),
        ));
  }
}
