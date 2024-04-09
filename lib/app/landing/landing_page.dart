import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../constants/asserts.dart';
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      context.goNamed("Login");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset(AssetsManager.chatBubble),
            const SizedBox(height: 20),
            const Text(
              'Welcome to Chat app',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                // 去掉下划线
                decoration: TextDecoration.none,
              ),
            ),
            // const LinearProgressIndicator()
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import '../constants/asserts.dart';
//
// class LandingPage extends StatelessWidget {
//  const LandingPage({super.key});
//  @override
//  void initState() {
//    super.initState();
//    Future.delayed(const Duration(seconds: 3), () {
//      Navigator.pushReplacementNamed(context, '/home');
//    });
//
//   @override
//   Widget build(BuildContext context) {
//
//   }
// }

