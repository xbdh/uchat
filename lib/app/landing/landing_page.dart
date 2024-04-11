import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:uchat/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:uchat/user/presentation/cubit/user/user_cubit.dart';

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
    Future.delayed(const Duration(seconds: 2), () {
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
           String uid = state.uid;
           BlocProvider.of<UserCubit>(context).getDataLocal();
          context.goNamed("Home", pathParameters: {"uid": uid});
        } else if (state is UnAuthenticated) {
          context.goNamed("Login");
        }
      },
      builder: (context, state) {
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
      },
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

