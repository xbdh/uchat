


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