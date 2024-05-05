import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uchat/app/widgets/user_avatar.dart';
import 'package:uchat/chat/presentation/pages/chat_list_page.dart';
import 'package:uchat/chat/presentation/pages/group_page.dart';
import 'package:uchat/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import 'package:uchat/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import 'package:uchat/user/presentation/cubit/my_entity/my_entity_cubit.dart';
import 'package:uchat/user/presentation/cubit/user/user_cubit.dart';
import 'package:uchat/user/presentation/pages/people_page.dart';

import '../../chat/presentation/cubit/notifications/notification_cubit.dart';
import '../../chat/presentation/widgets/call_overlay.dart';
import '../../main.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage({super.key, required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  String ImageUrl = '';

  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  List<Widget> pages = [ChatListPage(), GroupPage(), PeoplePage()];


  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    WidgetsBinding.instance!.addObserver(this);
    //final fcmToken = fcmTokenfn();
    //String? fcmToken = await FirebaseMessaging.instance.getToken();
    BlocProvider.of<UserCubit>(context).bindFcmToken(widget.uid);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("\n notification on onMessage function \n");
      // 将消息传递给 Cubit
      BlocProvider.of<NotificationCubit>(context).receiveNotification(message);
    });
  }


  @override
  void dispose() {
    _pageController.dispose(); // 记得释放资源
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  // did change App lifecycle state
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // if (state == AppLifecycleState.resumed) {
    //   BlocProvider.of<UserCubit>(context).setUserOnlineStatus(true);
    // } else {
    //   BlocProvider.of<UserCubit>(context).setUserOnlineStatus(false);
    // }

    switch (state) {
      case AppLifecycleState.resumed:
      // user comes back to the app
      // update user status to online
        BlocProvider.of<UserCubit>(context).setUserOnlineStatus(true);
        // 应该还要更新一下用户的lastSeen
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      // app is inactive, paused, detached or hidden
      // update user status to offline
        BlocProvider.of<UserCubit>(context).setUserOnlineStatus(false);
        break;
      default:
      // handle other states
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationCubit, NotificationState>(
      listener: (context, state) {
        if (state is NotificationReceiveSuccess) {
          final friendUid = state.friendUid;
          final friendName = state.friendName;
          final friendImage = state.friendImage;
          final callType = state.callType;
         final overlay = CallOverlay(
            context,
          );
         overlay.show(
            //friendUid: friendUid,
            friendName: friendName,
            friendImage: friendImage,
            onAccept: (){
              context.goNamed('VoiceCall',
                queryParameters: {
                  'friendUid': friendUid,
                  'friendName': friendName,
                  'friendImage': friendImage,
                  'role': 'audience',
                  //'callType': callType,
                },
              );
            },
            onReject: (){
              overlay.remove();
            },
            //callType: callType,
          );
        }
      },
      child: BlocConsumer<GetSingleUserCubit, GetSingleUserState>(
        listener: (context, state) {
          if (state is GetSingleUserLoaded) {
            final myEntity = state.singleUser;
            BlocProvider.of<MyEntityCubit>(context).setUser(myEntity);
          }
        },
        builder: (context, state) {
          return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
            builder: (context, getSingleUserstate) {
              return Scaffold(
                  appBar: AppBar(
                    title: Text(widget.uid),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UserAvatar(
                          imageUrl: getSingleUserstate is GetSingleUserLoaded
                              ? getSingleUserstate.singleUser.image
                              : '',
                          onPressed: () {
                            context.pushNamed("Profile", pathParameters: {
                              'uid': widget.uid,
                              'loginUid': widget.uid
                            });
                          },
                          radius: 20,
                        ),
                      )
                    ],
                  ),
                  body: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    children: pages,
                  ),
                  floatingActionButton: currentIndex == 1
                      ? FloatingActionButton(
                    onPressed: () {
                      context.pushNamed('CreateGroup');
                    },
                    child: const Icon(CupertinoIcons.add),
                  )
                      : null,
                  bottomNavigationBar: BottomNavigationBar(
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.chat_bubble_2_fill),
                        label: 'Chats',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.group),
                        label: 'Groups',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.globe),
                        label: 'People',
                      ),
                    ],
                    currentIndex: currentIndex,
                    onTap: (index) {
                      _pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                      setState(() {
                        currentIndex = index;
                      });
                      //print("Current Index: $index");
                    },
                  ));
            },
          );
        },
      ),
    );
  }
}

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Group extends StatelessWidget {
  const Group({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class People extends StatelessWidget {
  const People({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
