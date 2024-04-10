import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:go_router/go_router.dart';
import 'package:uchat/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:uchat/user/presentation/cubit/user/user_cubit.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});


  @override
  Widget build(BuildContext context) {
    //final authProvider=BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<AuthCubit, AuthState>(

      listener: (context, authBuilderState) {
        if (authBuilderState is AuthSignUpSuccess) {
          context.goNamed("Info");

        } else if (authBuilderState is AuthSignUpFail) {
          debugPrint("Sign up failed");
        } else if (authBuilderState is AuthLogInSuccess) {
          context.goNamed("Home");
        } else if (authBuilderState is AuthLogInFail) {
          debugPrint("Sign up failed");
        }else if (authBuilderState is AuthCheckUserExist) {
          debugPrint("User exist");
        }
      },
      builder: (context, authBuilderState) {
        return FlutterLogin(
              title: 'uchat',
              logo: const AssetImage('assets/images/chat.png'),
              onLogin: (data) async {
                // BlocProvider.of<AuthCubit>(context).checkUserExists(data.name);
                // if (authBuilderState is AuthCheckUserExist && !authBuilderState.isExist) {
                //   return 'User does not exist';
                // }else {
                  BlocProvider.of<AuthCubit>(context).submitLogIn(
                      email: data.name, password: data.password);
                  if (authBuilderState is AuthLogInSuccess) {
                    return null;
                  } else {
                    return 'Login failed';
                  }
                // }
              },
              onSignup: (data) async {
                String email = data.name ?? '';
                String password = data.password ?? '';
                // BlocProvider.of<AuthCubit>(context).checkUserExists(email);
                // if (authBuilderState is AuthCheckUserExist && authBuilderState.isExist) {
                //   return 'User already exists';
                // }else {
                  BlocProvider.of<AuthCubit>(context).submitSignUp(
                      email: email, password: password);
                  if (authBuilderState is AuthSignUpSuccess) {
                    return null;
                  } else if (authBuilderState is AuthSignUpFail) {
                    return 'Signup failed ';
                  }
                // }

              },
              onRecoverPassword: (name) async {
                BlocProvider.of<AuthCubit>(context).submitLogIn(
                    email: name, password: '');
                if (authBuilderState is AuthLogInSuccess) {
                  return null;
                } else if (authBuilderState is AuthLogInFail) {
                  return 'Recover password failed';
                }
              },
            );
          },
        );
  }
}