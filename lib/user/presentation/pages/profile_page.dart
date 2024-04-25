import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uchat/app/utils/methods.dart';
import 'package:uchat/user/presentation/widgets/user_info_details_card.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:uchat/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';

import 'package:uchat/app/widgets/setting_list_title.dart';

class ProfilePage extends StatefulWidget {
  final String loginUid;
  final String uid;

  const ProfilePage({super.key, required this.uid, required this.loginUid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDarkMode = false;

  // get the saved theme mode
  void getThemeMode() async {
    // get the saved theme mode
    final savedThemeMode = await AdaptiveTheme.getThemeMode();
    // check if the saved theme mode is dark
    if (savedThemeMode == AdaptiveThemeMode.dark) {
      // set the isDarkMode to true
      setState(() {
        isDarkMode = true;
      });
    } else {
      // set the isDarkMode to false
      setState(() {
        isDarkMode = false;
      });
    }
  }

  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    super.initState();
    // get the saved theme mode
    // get the single user
  }



  @override
  Widget build(BuildContext context) {
    late final UserEntity userEntity;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
      ),
      body: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, getSingleUserState) {
          if (getSingleUserState is GetSingleUserLoaded) {
            userEntity = getSingleUserState.singleUser;

            return BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLogOutSuccess) {
                  context.pop();
                  context.goNamed('Login');
                }
              },
              child: singleChildScrollView(userEntity),
            );
          }else if (getSingleUserState is GetUserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return const Center(
              child: Text('Failed to load user'),
            );
          }

        },
      ),
    );
  }

  Widget singleChildScrollView(UserEntity userEntity){
    final friendNumber = userEntity.friendsUIDs.length;
    final requestNumber = userEntity.friendRequestsFromUIDs.length;

    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // InfoDetailsCard(
            //   userModel: userModel,
            // ),
            UserInfoDetailsCard(
                loginUid: widget.uid,
                userEntity: userEntity),

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
                    title: 'Friends',
                    icon: Icons.people_alt_outlined,
                    iconContainerColor: Colors.deepPurple,
                    number: friendNumber,
                    onTap: () {
                        context.pushNamed(
                          "Friends",
                        );
                    },
                  ),
                  SettingsAndStatusListTile(
                    title: 'Requests',
                    icon: Icons.person_add_alt_1_outlined,
                    iconContainerColor: Colors.blue,
                    number: requestNumber,
                    onTap: () {
                      context.pushNamed(
                        "FriendRequests",
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Settings',
                style: GoogleFonts.openSans(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Column(
                children: [
                  SettingsAndStatusListTile(
                    title: 'Account',
                    icon: Icons.person,
                    iconContainerColor: Colors.deepPurple,
                    onTap: () {
                      // navigate to account settings
                    },
                  ),
                  SettingsAndStatusListTile(
                    title: 'My Media',
                    icon: Icons.image,
                    iconContainerColor: Colors.green,
                    onTap: () {
                      // navigate to account settings
                    },
                  ),
                  SettingsAndStatusListTile(
                    title: 'Notifications',
                    icon: Icons.notifications,
                    iconContainerColor: Colors.red,
                    onTap: () {
                      // navigate to account settings
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Column(
                children: [
                  SettingsAndStatusListTile(
                    title: 'Help',
                    icon: Icons.help,
                    iconContainerColor: Colors.yellow,
                    onTap: () {
                      // navigate to account settings
                    },
                  ),
                  SettingsAndStatusListTile(
                    title: 'Share',
                    icon: Icons.share,
                    iconContainerColor: Colors.blue,
                    onTap: () {
                      // navigate to account settings
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      isDarkMode
                          ? Icons.nightlight_round
                          : Icons.wb_sunny_rounded,
                      color: isDarkMode ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                title: const Text('Change theme'),
                trailing: Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      // set the isDarkMode to the value
                      setState(() {
                        isDarkMode = value;
                      });
                      // check if the value is true
                      if (value) {
                        // set the theme mode to dark
                        AdaptiveTheme.of(context).setDark();
                      } else {
                        // set the theme mode to light
                        AdaptiveTheme.of(context).setLight();
                      }
                    }),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Column(
                children: [
                  SettingsAndStatusListTile(
                    title: 'Logout',
                    icon: Icons.logout_outlined,
                    iconContainerColor: Colors.red,
                    onTap: () {
                      showMyAnimatedDialog(
                        context: context,
                        title: 'Logout',
                        content: 'Are you sure you want to logout?',
                        textAction: 'Logout',
                        onActionTap: (value) {
                          if (value) {
                            // logout
                            // context
                            //     .read<AuthenticationProvider>()
                            //     .logout()
                            //     .whenComplete(() {
                            //   Navigator.pop(context);
                            //   Navigator.pushNamedAndRemoveUntil(
                            //     context,
                            //     Constants.loginScreen,
                            //         (route) => false,
                            //   );
                            // });
                            BlocProvider.of<AuthCubit>(context)
                                .logOut();
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
