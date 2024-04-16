import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uchat/user/presentation/widgets/user_info_details_card.dart';
import 'package:uchat/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
// import main_injection_container.dart as di;
import 'package:uchat/main_injection_container.dart' as di;
import 'package:uchat/user/presentation/widgets/other_profile_buttons.dart';

class OtherProfilePage extends StatefulWidget {
  final String uid;
  final String loginUid;

  const OtherProfilePage(
      {super.key, required this.uid, required this.loginUid});

  // Widget build(BuildContext context) {
  //   return const OtherProfilePage();
  // }

  @override
  State<OtherProfilePage> createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {

  @override
  void initState() {
    //BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    super.initState();
    // get the saved theme mode
    // get the single user
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<GetSingleUserCubit>()..getSingleUser(uid: widget.uid),

      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Other Profile"),
        ),
        body: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
          builder: (context, getUserState) {
            if (getUserState is GetSingleUserLoaded) {
              final userEntity = getUserState.singleUser;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserInfoDetailsCard(
                        userEntity: userEntity,
                        loginUid: widget.loginUid,
                      ),

                      const SizedBox(height: 10),
                      OtherProfileButton(
                        loginUid: widget.loginUid,
                        userEntity: userEntity,
                      ),
                    ],


                  ),
                ),
              );
            } else if (getUserState is GetSingleUserFailure){
              return const Center(
                child: Text("Error"),
              );
            }  else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),

      ),
    );
  }

  Widget otherProfileButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Message'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Add Friend'),
        ),
      ],
    );
  }
}
