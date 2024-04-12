


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// pick image from gallery or camera
Future<File?> pickImage({
  required BuildContext context,
  required bool fromCamera,
  required Function(String) onFail
}) async {
  File? fileImage;
  if (fromCamera) {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        fileImage = File(pickedImage.path);
      } else {
        onFail('No image selected');
      }
    } catch (e) {
      onFail(e.toString());
    }} else {
      try {
        final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedImage != null) {
          fileImage = File(pickedImage.path);
        } else {
          onFail('No image selected');
        }
      } catch (e) {
        onFail(e.toString());
      }
    }
    return fileImage;
}
  // pick video from gallery or camera
Future<File?> pickVideo({
    required BuildContext context,
    required bool fromCamera,
    required Function(String) onFail
}) async {
    File? fileVideo;
    if (fromCamera) {
      try {
        final pickedVideo = await ImagePicker().pickVideo(source: ImageSource.camera);
        if (pickedVideo != null) {
          fileVideo = File(pickedVideo.path);
        } else {
          onFail('No video selected');
        }
      } catch (e) {
        onFail(e.toString());
      }} else {
        try {
          final pickedVideo = await ImagePicker().pickVideo(source: ImageSource.gallery);
          if (pickedVideo != null) {
            fileVideo = File(pickedVideo.path);
          } else {
            onFail('No video selected');
          }
        } catch (e) {
          onFail(e.toString());
        }
      }
    return fileVideo;
}

// show snackbar
void showSnackBar({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
          message,
          style: const TextStyle(
            fontSize: 16
          ),
      ),
    ),
  );
}

void showMyAnimatedDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String textAction,
  required Function(bool) onActionTap,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation1, animation2) {
      return Container();
    },
    transitionBuilder: (context, animation1, animation2, child) {
      return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation1),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation1),
            child: AlertDialog(
              title: Text(
                title,
                textAlign: TextAlign.center,
              ),
              content: Text(
                content,
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onActionTap(false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onActionTap(true);
                  },
                  child: Text(textAction),
                ),
              ],
            ),
          ));
    },
  );
}
