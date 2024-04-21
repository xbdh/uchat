import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:go_router/go_router.dart';
import 'package:uchat/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:uchat/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:uchat/user/presentation/cubit/user/user_cubit.dart';

import '../cubit/uid/uid_cubit.dart';


class LoginPage extends StatefulWidget {

  const LoginPage({super.key});
 

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String errorMesssage = '';

  @override
  Widget build(BuildContext context) {
    //final authProvider=BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<CredentialCubit, CredentialState>(

      listener: (context, credentialState) {

        if (credentialState is CredentialSignupSuccess) {

           final  uid = credentialState.uid;


          context.goNamed("Info", pathParameters: {'uid': uid,"email": email});
        // } else if (credentialState is CredentialFailure) {
        //  setState(() {
        //     errorMesssage = credentialState.errorMessage;
        //  });
        } else if (credentialState is CredentialLoginSuccess) {

            final uid = credentialState.uid;
            BlocProvider.of<UidCubit>(context).setUid(uid);
          context.goNamed("Home",pathParameters: {'uid': uid});
          //context.goNamed("Info", pathParameters: {'uid': uid,"email": email});
        }

      },
      builder: (context, credentialState) {
        return FlutterLogin(
              title: 'uchat',
              logo: const AssetImage('assets/images/chat.png'),
              onLogin: (data) async {

                  BlocProvider.of<CredentialCubit>(context).submitLogIn(
                      email: data.name, password: data.password);
                  if (credentialState is CredentialFailure) {
                    return credentialState.errorMessage;
                  } else {
                    return null;
                  }

              },
              onSignup: (data) async {
                String signupEmail = data.name!;
                String signupPassword = data.password!;
                setState(() {
                  email = signupEmail;
                });

                  BlocProvider.of<CredentialCubit>(context).submitSignUp(
                      email: signupEmail, password: signupPassword);
                  if (credentialState is CredentialFailure) {
                    return credentialState.errorMessage;
                  } else {
                    return null;

                  }


              },
              onRecoverPassword: (name) async {
                 return null;
              },
            );
          },
        );
  }
}