import 'package:uchat/app/home/home_page.dart';
import 'package:uchat/app/landing/landing_page.dart';
import 'package:uchat/chat/presentation/pages/chat_page.dart';
import 'package:uchat/chat/presentation/pages/create_group_page.dart';
import 'package:uchat/chat/presentation/pages/private_group_page.dart';
import 'package:uchat/chat/presentation/pages/public_group_list_page.dart';
import 'package:uchat/user/presentation/pages/friend_requests_page.dart';
import 'package:uchat/user/presentation/pages/friends_page.dart';
import 'package:uchat/user/presentation/pages/info_page.dart';
import 'package:uchat/user/presentation/pages/login_page.dart';
import 'package:go_router/go_router.dart';
import 'package:uchat/user/presentation/pages/other_profile_page.dart';
import 'package:uchat/user/presentation/pages/people_page.dart';
import 'package:uchat/user/presentation/pages/profile_page.dart';

import '../../chat/presentation/pages/public_group_page.dart';

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

    GoRoute(
      name: "Chat",
      path: '/chat',
      builder: (context, state) => ChatPage(
        friendUid: state.uri.queryParameters['friendUid']!,
        friendName: state.uri.queryParameters['friendName']!,
        friendImage: state.uri.queryParameters['friendImage']!,
        groupID: state.uri.queryParameters['groupID'],
      ),
    ),

    GoRoute(
      name: "CreateGroup",
      path: '/create_group',
      builder: (context, state) => CreateGroupPage(),
    ),

    GoRoute(
      name: "PrivateGroup",
      path: '/private_group',
      builder: (context, state) => PrivateGroupPage(
        groupId: state.uri.queryParameters['groupId']!,
        groupName: state.uri.queryParameters['groupName']!,
        groupImage: state.uri.queryParameters['groupImage']!,
      )
    ),

    GoRoute(
      name: "PublicGroup",
      path: '/public_group',
      builder: (context, state) =>PublicGroupPage(
        groupId: state.uri.queryParameters['groupId']!,
        groupName: state.uri.queryParameters['groupName']!,
        groupImage: state.uri.queryParameters['groupImage']!,
      )
    )
  ],
);