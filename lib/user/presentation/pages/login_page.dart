import 'package:uchat/app/constants/asserts.dart';
import 'package:uchat/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }


  final TextEditingController _phoneController = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  // 新西兰, 中国, 美国
  List<String> countries = ['US',"CN","NZ"];
  String phoneNumber = '2512090497';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child:Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: [
               const SizedBox( height: 50),
               SizedBox(
                width: 200,
                height: 200,
                child: Lottie.asset(AssetsManager.chatBubble),
              ),
              Text(
                'Chat XBDH',
                style: GoogleFonts.openSans(
                  fontSize: 28,
                  fontWeight: FontWeight.w500
                ),

              ),
              const SizedBox(height: 20),

              Text(
                'Add your phone number will send you a code to verify ',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),
              InternationalPhoneNumberInput(
                countries: countries,

                onInputChanged: (PhoneNumber number) {
                 setState(() {
                   phoneNumber = number.phoneNumber!;
                 });
                  print("Phone Number: $phoneNumber");
                },

                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  useBottomSheetSafeArea: true,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: const TextStyle(color: Colors.black),
                initialValue: number,
                //textFieldController: _phoneController,
                formatInput: true,
                keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                inputBorder: const OutlineInputBorder(),
                keyboardAction: TextInputAction.done,
              ),

              const SizedBox(height: 30),
             // button 填充
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print("++Phone Number: ${phoneNumber}");
                    BlocProvider.of<CredentialCubit>(context).submitVerifyPhoneNumber(phoneNumber: phoneNumber);
                    print("++Phone Number: ${phoneNumber}");

                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
