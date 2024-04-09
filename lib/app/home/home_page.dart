
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/asserts.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  List<Widget> pages = [
    const Chat(),
    const Group(),
    const People(),
  ];

  @override
  void dispose() {
    _pageController.dispose(); // 记得释放资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage:AssetImage(AssetsManager.userAvtar),
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
              icon: Icon(CupertinoIcons.chat_bubble_2_fill  ),
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

          currentIndex:  currentIndex,
          onTap: (index) {
            _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn
            );
            setState(() {
              currentIndex = index;
            });
            //print("Current Index: $index");
          } ,
        )


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





