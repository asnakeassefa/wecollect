import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wecollect/core/utility/theme/theme.dart';
import 'package:wecollect/feature/auth/presentation/screen/login.dart';

import '../../../../core/dj/injection.dart';
import '../../../../core/utility/widget/button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';

class SignupScreen extends StatefulWidget {
  final String role;
  final bool type;
  const SignupScreen({super.key, required this.role, required this.type});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

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
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return const LoginScreen();
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
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 32,
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      RichText(
                        text: const TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Create an ',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                            TextSpan(
                                text: 'account ',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: 'to initiate trash collection using ',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                            TextSpan(
                                text: 'We Collect!',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        ' Email',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "johndoi@example.com",
                          hintStyle: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w300),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(Icons.phone,
                                color: AppColors.secondaryColor),
                          ),
                        ),

                        // validate if the email is valid or phone is valid
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        ' Your Name',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "John Doi",
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(Icons.person,
                                color: AppColors.secondaryColor),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        ' Phone Number',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      IntlPhoneField(
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'ET',
                        onChanged: (phone) {
                          _phoneController.text = phone.completeNumber;
                        },
                      ),
                      const Text(
                        ' Password',
                        style: TextStyle(fontSize: 16),
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
                      const SizedBox(height: 24),
                      CustomButton(
                          isLoading: state is AuthLoading,
                          onPressed: () {
                            if ((formKey as GlobalKey<FormState>)
                                .currentState!
                                .validate()) {
                              context.read<AuthCubit>().register(
                                {
                                  "email": _emailController.text,
                                  "name": _nameController.text,
                                  "password": _passwordController.text,
                                  "password2": _passwordController.text,
                                  "phone_number": _phoneController.text,
                                  'latitude': 0.0,
                                  'longitude': 0.0,
                                  "role": widget.role,
                                  "is_organization": widget.type
                                },
                              );
                            }
                          },
                          text: 'REGISTER'),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(fontSize: 16),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const LoginScreen();
                              }));
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline),
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
