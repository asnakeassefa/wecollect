import 'package:flutter/material.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

import '../../../../core/utility/widget/button.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
                'Reset Password',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor),
              ),
              const SizedBox(height: 24),
              const Text(
                'Enter the new password below so you can login',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 32),
              const Text(
                ' Enter Password',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
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
              const SizedBox(height: 24),
              const Text(
                ' Re-enter Password',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
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
              const SizedBox(height: 80),
              CustomButton(onPressed: () {}, text: "DONE"),
            ],
          ),
        ),
      ),
    );
  }
}
