import 'package:flutter/material.dart';

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
          case GroupPopupMenuOption.edit:
            //onEdit();
            break;
          case GroupPopupMenuOption.delete:
            //onDelete();
            break;
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: GroupPopupMenuOption.edit,
            child: Text('Group Info'),
          ),
          PopupMenuItem(
            value: GroupPopupMenuOption.delete,
            child: Text('Setting'),
          ),
        ];
      },
    );
  }
}
enum GroupPopupMenuOption {
  edit,
  delete,
}