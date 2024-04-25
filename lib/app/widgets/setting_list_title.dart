import 'dart:io';

import 'package:flutter/material.dart';

class SettingsAndStatusListTile extends StatelessWidget {
  const SettingsAndStatusListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.number,
    required this.icon,
    required this.iconContainerColor,
    required this.onTap,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Color iconContainerColor;
  final int? number;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        decoration: BoxDecoration(
          color: iconContainerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(title),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      // if number is not null, display it
      trailing: number != null
          ? CircleAvatar(child: Text(number.toString()))
          : Icon(
              Platform.isAndroid
                  ? Icons.arrow_forward
                  : Icons.arrow_back_ios_new,
            ),
      onTap: onTap,
    );
  }
}
//
// class StatusListTile extends StatelessWidget {
//   const StatusListTile({
//     super.key,
//     required this.title,
//     this.subtitle,
//     required this.number,
//     required this.iconContainerColor,
//     required this.onTap,
//   });
//
//   final String title;
//   final String? subtitle;
//   final IconData icon;
//   final Color iconContainerColor;
//   final int? number;
//   final Function() onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       leading: Container(
//         decoration: BoxDecoration(
//           color: iconContainerColor,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Icon(
//             icon,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       title: Text(title),
//       subtitle: subtitle != null
//           ? Text(
//         subtitle!,
//         maxLines: 3,
//         overflow: TextOverflow.ellipsis,
//       )
//           : null,
//       trailing:Icon(
//         Platform.isAndroid ? Icons.arrow_forward : Icons.arrow_back_ios_new,
//       ),
//       onTap: onTap,
//     );
//   }
// }
