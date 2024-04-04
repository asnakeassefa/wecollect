import 'package:flutter/material.dart';
import 'package:wecollect/core/utility/theme/theme.dart';
import 'package:wecollect/core/utility/widget/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
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
                ' phone',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Ex: 0910111213",
                    hintStyle: const TextStyle(color: Colors.grey),
                    icon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child:
                            Icon(Icons.phone, color: AppColors.secondaryColor)),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                ' Password',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "********",
                    hintStyle: const TextStyle(color: Colors.grey),
                    icon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.lock_outline,
                            color: AppColors.secondaryColor)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
              ),
              const SizedBox(height: 70),
              CustomButton(onPressed: () {}, text: "LOGIN"),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
