import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:go_router/go_router.dart';
import 'package:uchat/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:uchat/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:uchat/user/presentation/cubit/user/user_cubit.dart';


class LoginPage extends StatefulWidget {

  const LoginPage({super.key});
 

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';

  @override
  Widget build(BuildContext context) {
    //final authProvider=BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<CredentialCubit, CredentialState>(

      listener: (context, credentialState) {

        if (credentialState is CredentialSignupSuccess) {

           final  uid = credentialState.uid;


          context.goNamed("Info", pathParameters: {'uid': uid,"email": email});
        } else if (credentialState is CredentialFailure) {
          debugPrint("sign up or login  failed");
        } else if (credentialState is CredentialLoginSuccess) {

            final uid = credentialState.uid;


          context.goNamed("Home",pathParameters: {'uid': uid});
          //context.goNamed("Info", pathParameters: {'uid': uid,"email": email});
        }
      },
      builder: (context, credentialState) {
        return FlutterLogin(
              title: 'uchat',
              logo: const AssetImage('assets/images/chat.png'),
              onLogin: (data) async {
                // BlocProvider.of<AuthCubit>(context).checkUserExists(data.name);
                // if (authBuilderState is AuthCheckUserExist && !authBuilderState.isExist) {
                //   return 'User does not exist';
                // }else {
                  BlocProvider.of<CredentialCubit>(context).submitLogIn(
                      email: data.name, password: data.password);
                  if (credentialState is CredentialLoginSuccess) {
                    return null;
                  } else {
                    return 'Login failed';
                  }
                // }
              },
              onSignup: (data) async {
                String signupEmail = data.name!;
                String signupPassword = data.password!;
                setState(() {
                  email = signupEmail;
                });
                // BlocProvider.of<AuthCubit>(context).checkUserExists(email);
                // if (authBuilderState is AuthCheckUserExist && authBuilderState.isExist) {
                //   return 'User already exists';
                // }else {
                  BlocProvider.of<CredentialCubit>(context).submitSignUp(
                      email: signupEmail, password: signupPassword);
                  if (credentialState is CredentialSignupSuccess) {
                    return null;
                  } else if (credentialState is CredentialFailure) {
                    return 'Signup failed ';
                  }
                // }

              },
              onRecoverPassword: (name) async {
                 return null;
              },
            );
          },
        );
  }
}