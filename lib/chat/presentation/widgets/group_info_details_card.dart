import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uchat/app/widgets/user_avatar.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';

import '../../domain/entities/group_entity.dart';

class GroupInfoDetailsCard extends StatelessWidget {
  final String groupId;
  final GroupEntity groupEntity;

  const GroupInfoDetailsCard({
    super.key,
    required this.groupId,
    required this.groupEntity,
  });

  @override
  Widget build(BuildContext context) {
   final groupImage = groupEntity.groupImage;
    final groupName = groupEntity.groupName;
    final groupDescription = groupEntity.groupDescription;
    final groupType = groupEntity.isPrivate? 'Private': 'Public';
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment:  CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UserAvatar(
                  imageUrl: groupImage,
                  radius: 50,
                  onPressed: () {},
                ),
                //const SizedBox(width: 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      groupName,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                     Text(
                     groupType,
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )
                    )


                  ],
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Text(
             'About Group',
              style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              groupDescription,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),

    );
  }
}