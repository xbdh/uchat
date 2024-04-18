import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uchat/app/widgets/user_avatar.dart';
import 'package:uchat/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import 'package:uchat/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import 'package:uchat/user/presentation/cubit/my_entity/my_entity_cubit.dart';
import 'package:uchat/user/presentation/cubit/user/user_cubit.dart';
import 'package:uchat/user/presentation/pages/people_page.dart';

import '../../main.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage({super.key, required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String ImageUrl = '';

  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  List<Widget> pages = [
    const Chat(),
    const Group(),
    PeoplePage()
  ];

  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose(); // 记得释放资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetSingleUserCubit, GetSingleUserState>(
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
                          context.pushNamed("Profile",
                              pathParameters: {
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
