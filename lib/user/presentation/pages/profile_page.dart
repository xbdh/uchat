import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uchat/app/utils/methods.dart';
import 'package:uchat/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:uchat/user/presentation/widgets/setting_list_title.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({super.key, required this.uid});

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLogOutSuccess) {
            context.pop();

              context.goNamed('Login');
          }
        },
        child: SingleChildScrollView(
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
                      SettingsListTile(
                        title: 'Account',
                        icon: Icons.person,
                        iconContainerColor: Colors.deepPurple,
                        onTap: () {
                          // navigate to account settings
                        },
                      ),
                      SettingsListTile(
                        title: 'My Media',
                        icon: Icons.image,
                        iconContainerColor: Colors.green,
                        onTap: () {
                          // navigate to account settings
                        },
                      ),
                      SettingsListTile(
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
                      SettingsListTile(
                        title: 'Help',
                        icon: Icons.help,
                        iconContainerColor: Colors.yellow,
                        onTap: () {
                          // navigate to account settings
                        },
                      ),
                      SettingsListTile(
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
                      SettingsListTile(
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
                                BlocProvider.of<AuthCubit>(context).logOut();
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
        ),
      ),
    );
  }
}
