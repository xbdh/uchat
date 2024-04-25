import 'package:flutter/material.dart';

class PublicGroupPage extends StatefulWidget {
  final String groupId;

  final String groupName;

  final String groupImage;
  const PublicGroupPage({super.key,
    required this.groupId,
    required this.groupName,
    required this.groupImage,
  });
  @override
  State<PublicGroupPage> createState() => _PublicGroupPageState();
}

class _PublicGroupPageState extends State<PublicGroupPage> {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Public Group List'),
    );
  }
}