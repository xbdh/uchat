import 'package:flutter/material.dart';

class FriendRequestButton extends StatelessWidget {
  // final bool isFriend;
  // final VoidCallback onPressed;
  const FriendRequestButton({
    super.key,
    // required this.isFriend,
    // required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {  },
      child: const Text("Requests"),
    );
  }
}