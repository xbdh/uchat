import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uchat/app/widgets/profile_status.dart';
import 'package:uchat/app/widgets/user_avatar.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/presentation/pages/profile_page.dart';

class UserInfoDetailsCard extends StatelessWidget {
  final String loginUid;
  final UserEntity userEntity;

  const UserInfoDetailsCard({
    super.key,
    required this.loginUid,
    required this.userEntity,
  });

  @override
  Widget build(BuildContext context) {
    final userAvatar = userEntity.image;
    final userName = userEntity.name;
    final userEmail = userEntity.email;
    final userAbout = userEntity.aboutMe;
    final userUid = userEntity.uid;
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
                  imageUrl: userAvatar,
                  radius: 50,
                  onPressed: () {},
                ),
                //const SizedBox(width: 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                     Text(
                      userEmail,
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
              loginUid == userUid ?'About Me': 'About Her/Him',
              style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              userAbout,
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