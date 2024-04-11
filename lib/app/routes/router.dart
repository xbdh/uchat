import 'package:uchat/app/home/home_page.dart';
import 'package:uchat/app/landing/landing_page.dart';
import 'package:uchat/user/presentation/pages/info_page.dart';
import 'package:uchat/user/presentation/pages/login_page.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final chatRouter = GoRouter(
  initialLocation: '/landing',
  routes: [
    GoRoute(
        name: "Landing",
        path: '/landing',
        builder: (context, state) => const LandingPage()
    ),
    GoRoute(
      name: "Home",
      path: '/home/:uid',
      builder: (context, state) => HomePage(
        uid: state.pathParameters['uid']!,
      ),
    ),

    GoRoute(
      name: "Login",
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),

    GoRoute(
      name: "Info",
      path: '/info/:uid/:email',
      builder: (context, state) => InfoPage(
        email: state.pathParameters['email']!,
        uid: state.pathParameters['uid']!,
      ),
    )
  ],
);