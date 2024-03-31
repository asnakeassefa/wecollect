import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

import 'user_catagory.dart';

class WelcomeScreen extends StatefulWidget {
  static String routeName = '/welcome';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome!',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(child: SvgPicture.asset('assets/svg/welcome.svg')),
            const SizedBox(height: 24),
            const Text(
              "Let's Clean our Place with",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 8),
            const Text(
              '"We Collect"',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const UserCatagory(newAccount: false);
                }));
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.sizeOf(context).width * 0.75, 50),
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'LOGIN',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.sizeOf(context).width * 0.75, 50),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'SIGN UP',
                style: TextStyle(color: AppColors.bodyTextColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
