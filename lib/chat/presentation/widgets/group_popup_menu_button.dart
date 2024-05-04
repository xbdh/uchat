import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupPopupMenuButton extends StatelessWidget {
  const GroupPopupMenuButton({
    super.key,
    // required this.onEdit,
    // required this.onDelete,
    required this.groupId,
  });

  // final Group group;
  // final VoidCallback onEdit;
  // final VoidCallback onDelete;
  final String groupId;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<GroupPopupMenuOption>(
      onSelected: (option) {
        switch (option) {
          case GroupPopupMenuOption.info:
            context.pushNamed(
                'GroupInfo',
              queryParameters: {'groupId': groupId}
               );
            break;
          case GroupPopupMenuOption.setting:
            //onDelete();
            break;
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: GroupPopupMenuOption.info,
            child: Text('Group Info'),
          ),
          PopupMenuItem(
            value: GroupPopupMenuOption.setting,
            child: Text('Group Setting'),
          ),
        ];
      },
    );
  }
}
enum GroupPopupMenuOption {
  info,
  setting,
}