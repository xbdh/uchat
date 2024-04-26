import 'package:flutter/material.dart';

class GroupInfoPage extends StatefulWidget {
  final String groupId;

  const GroupInfoPage({super.key, required this.groupId});

  @override
  State<GroupInfoPage> createState() => _GroupInfoPageState();
}

class _GroupInfoPageState extends State<GroupInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Info"),
      ),
      body: Column(
        children: <Widget>[

        ],
      ),
    );
  }
}