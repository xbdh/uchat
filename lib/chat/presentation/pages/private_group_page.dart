import 'package:flutter/material.dart';

class PrivateGroupPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String groupImage;

  const PrivateGroupPage({super.key,
    required this.groupId,
    required this.groupName,
    required this.groupImage,
  });

  @override
  State<PrivateGroupPage> createState() => _PrivateGroupPageState();
}

class _PrivateGroupPageState extends State<PrivateGroupPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Private Group message'),
    );
  }
}