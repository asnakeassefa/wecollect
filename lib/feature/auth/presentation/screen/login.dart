import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wecollect/core/utility/theme/theme.dart';
import 'package:wecollect/core/utility/widget/button.dart';
import 'package:wecollect/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:wecollect/feature/auth/presentation/bloc/auth_state.dart';
import 'package:wecollect/feature/home_page.dart';

import '../../../../core/dj/injection.dart';
import '../../../onboarding/screen/user_catagory.dart';
import 'forgot.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey formKey = GlobalKey<FormState>();
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: true),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );

              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return const HomePage();
              }), (route) => false);
            }
            if (state is AuthError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 32,
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Login to your account!',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        ' phone/email',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "0912345678",
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(Icons.phone,
                                color: AppColors.secondaryColor),
                          ),
                        ),

                        // validate if the email is valid or phone is valid
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        ' Password',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: obscure,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "*********",
                          hintStyle: const TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                            icon: Icon(
                              obscure ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(Icons.lock,
                                color: AppColors.secondaryColor),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const ForgotPassword();
                          }));
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 70),
                      CustomButton(
                          isLoading: state is AuthLoading,
                          onPressed: () {
                            if ((formKey as GlobalKey<FormState>)
                                .currentState!
                                .validate()) {
                              Map<String, String> loginInfo = {
                                "username": _phoneController.text,
                                "password": _passwordController.text
                              };
                              context.read<AuthCubit>().login(loginInfo);
                            }
                          },
                          text: "LOGIN"),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(fontSize: 16),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const UserCatagory(
                                  newAccount: true,
                                );
                              }));
                            },
                            child: const Text(
                              'Register',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
