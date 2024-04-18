import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:logger/logger.dart';
import 'package:uchat/app/routes/router.dart';
import 'package:uchat/firebase_options.dart';
import 'package:uchat/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:uchat/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uchat/user/presentation/cubit/friend_list/friend_list_cubit.dart';
import 'package:uchat/user/presentation/cubit/friend_request/friend_request_cubit.dart';
import 'package:uchat/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import 'package:uchat/user/presentation/cubit/my_entity/my_entity_cubit.dart';
import 'package:uchat/user/presentation/cubit/uid/uid_cubit.dart';
import 'chat/presentation/cubit/message_reply/message_reply_cubit.dart';
import 'chat/presentation/cubit/send_text_message/send_text_message_cubit.dart';
import 'main_injection_container.dart' as di;
import 'user/presentation/cubit/user/user_cubit.dart';

final logger = Logger();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Add more cubit here
        // user cubit
        BlocProvider(
          create: (context) => di.sl<CredentialCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<UserCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<GetSingleUserCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<UidCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<FriendRequestCubit>(),
        ),

        BlocProvider(
          create: (context) => di.sl<FriendListCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<MyEntityCubit>(),
        ),
        // chat cubit
        BlocProvider(
          create: (context) => di.sl< MessageReplyCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<SendTextMessageCubit>(),
        ),



      ],
      child: AdaptiveTheme(
        light: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorSchemeSeed: Colors.deepPurple
        ),
        dark: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.deepPurple,
        ),
        initial: savedThemeMode ?? AdaptiveThemeMode.light,
        builder: (theme, darkTheme) =>
            MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Chat XBDH',
              theme: theme,
              darkTheme: darkTheme,
              routerConfig: chatRouter,
            ),
      ),
    );
  }
}
