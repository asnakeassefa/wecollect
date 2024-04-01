import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

import '../../../../core/utility/widget/button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot Password',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor),
              ),
              const SizedBox(height: 24),
              const Text(
                'To verify account, please enter your phone number or email',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Email/Phone No",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 80),
              CustomButton(onPressed: () {}, text: "SUBMIT"),
            ],
          ),
        ),
      ),
    );
  }
}
