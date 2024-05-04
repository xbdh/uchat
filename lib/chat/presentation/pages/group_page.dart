import 'package:flutter/material.dart';
import 'package:uchat/chat/presentation/pages/private_group_list_page.dart';
import 'package:uchat/chat/presentation/pages/public_group_list_page.dart';


class GroupPage extends StatelessWidget {
  GroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title:TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(text: 'Public'),
              Tab(text: 'Private'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PublicGroupListPage(),
            PrivateGroupListPage(),
          ],
        )
      ),
    );
  }
}