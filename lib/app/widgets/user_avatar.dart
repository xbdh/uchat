import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uchat/app/constants/asserts.dart';
class UserAvatar extends StatelessWidget {
  final String  imageUrl;
  final double radius;
  final VoidCallback onPressed;
  const UserAvatar({
    super.key,
    required this.imageUrl,
    this.radius = 20,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey[300],
        backgroundImage: imageUrl.isEmpty
            ? const AssetImage(AssetsManager.userAvtar) as ImageProvider
            : CachedNetworkImageProvider(imageUrl)
      ),
    );
  }
}
