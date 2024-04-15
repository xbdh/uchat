import 'package:flutter/material.dart';

class FriendButton extends StatelessWidget {
  // final bool isFriend;
  // final VoidCallback onPressed;
  const FriendButton({
    super.key,
    // required this.isFriend,
    // required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {  },
      child: const Text("Friends"),
    );
  }
}
