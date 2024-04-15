import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uchat/app/constants/asserts.dart';
class DisplayUserAvatar extends StatelessWidget {
 const DisplayUserAvatar({
    super.key,
    required this.finalFileImage,
    this.radius = 50,
    required this.onPressed,
  });

  final File? finalFileImage;
  final double radius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return finalFileImage==null?
    Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: const AssetImage(AssetsManager.userAvtar),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: (){
              onPressed ();
            },

            child: const CircleAvatar(
              backgroundColor: Colors.green,
              radius: 20,
              child: Icon(
                Icons.add_a_photo,
                color: Colors.white,
                size: 30,

              ),
            ),
          ),
        )
      ],
    ):Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage:  FileImage(File(finalFileImage!.path)),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: (){
             onPressed ();
            },

            child: const CircleAvatar(
              backgroundColor: Colors.green,
              radius: 20,
              child: Icon(
                Icons.add_a_photo,
                color: Colors.white,
                size: 30,

              ),
            ),
          ),
        )
      ],
    );
  }
}
