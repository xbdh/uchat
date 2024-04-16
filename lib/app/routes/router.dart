import 'package:uchat/app/home/home_page.dart';
import 'package:uchat/app/landing/landing_page.dart';
import 'package:uchat/user/presentation/pages/friend_requests_page.dart';
import 'package:uchat/user/presentation/pages/friends_page.dart';
import 'package:uchat/user/presentation/pages/info_page.dart';
import 'package:uchat/user/presentation/pages/login_page.dart';
import 'package:go_router/go_router.dart';
import 'package:uchat/user/presentation/pages/other_profile_page.dart';
import 'package:uchat/user/presentation/pages/people_page.dart';
import 'package:uchat/user/presentation/pages/profile_page.dart';

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
    ),
    GoRoute(
      name: "Profile",
      path: '/profile/:uid/:loginUid',
      builder: (context, state) =>  ProfilePage(
        loginUid: state.pathParameters['loginUid']!,
        uid: state.pathParameters['uid']!,
      ),
    ),

    GoRoute(
      name: "OtherProfile",
      path: '/other_profile',
      builder: (context, state) =>  OtherProfilePage(
        loginUid: state.uri.queryParameters['loginUid']!,
        uid: state.uri.queryParameters['uid']!,
      ),
    ),
    GoRoute(
      name: "People",
      path: '/people',
      builder: (context, state) => const PeoplePage(),
    ),
    GoRoute(
      name: "Friends",
      path: '/friends',
      builder: (context, state) => const FriendsPage(),
    ),

    GoRoute(
      name: "FriendRequests",
      path: '/friend_requests',
      builder: (context, state) => const FriendRequestsPage(),
    ),
  ],
);