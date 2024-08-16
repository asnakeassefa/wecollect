import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

import '../../../../core/dj/injection.dart';
import '../../../../core/utility/widget/button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import 'login.dart';

class OtpPage extends StatefulWidget {
  static const routeName = '/otp';
  final String id;
  const OtpPage({super.key, required this.id});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String otpText = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(), // Add the missing argument here
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Otp verified'),
                ),
              );

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                return const LoginScreen();
              }), (route) => false);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Verification Code',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 24),
                    Text('We emaild you a code to verify your email',
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 50),
                    OtpTextField(
                      fieldWidth: 50,
                      fieldHeight: 50,
                      borderRadius: BorderRadius.circular(20),
                      cursorColor: AppColors.primaryColor,
                      numberOfFields: 4,
                      borderColor: AppColors.primaryColor,
                      focusedBorderColor: AppColors.primaryColor,
                      showFieldAsBox: true,
                      onCodeChanged: (String code) {
                        otpText = code;
                      },
                      onSubmit: (String verificationCode) {}, // end onSubmit
                    ),
                    const SizedBox(height: 60),
                    CustomButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return const LoginScreen();
                        }), (route) => false);
                      },
                      text: 'Verify',
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
