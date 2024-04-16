import 'package:flutter/material.dart';
import 'package:wecollect/core/utility/theme/theme.dart';
import 'package:wecollect/feature/auth/presentation/screen/signup.dart';

import '../../../core/utility/widget/button.dart';

class UserCatagory extends StatefulWidget {
  static String routeName = '/user_catagory';
  final bool newAccount;
  const UserCatagory({super.key, required this.newAccount});

  @override
  State<UserCatagory> createState() => _UserCatagoryState();
}

class _UserCatagoryState extends State<UserCatagory> {
  Color selectedColor1 = AppColors.primaryColor;
  Color selectedColor2 = AppColors.primaryColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'Choose your catagory',
                      style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      'Welcome back! please select your role',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedColor1 == Colors.red) {
                          selectedColor1 = AppColors.primaryColor;
                        } else {
                          if (selectedColor2 == Colors.red) {
                            selectedColor2 = AppColors.primaryColor;
                          }
                          selectedColor1 = Colors.red;
                        }
                      });
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * .43,
                      height: MediaQuery.sizeOf(context).height * .3,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: selectedColor1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            width: 87,
                            height: 97,
                            'assets/images/onboarding5.png',
                          ),
                          const Text(
                            'Initiate Trash Collection',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff8185FC),
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'For users who wish to request trash collection.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedColor2 == Colors.red) {
                          selectedColor2 = AppColors.primaryColor;
                        } else {
                          if (selectedColor1 == Colors.red) {
                            selectedColor1 = AppColors.primaryColor;
                          }
                          selectedColor2 = Colors.red;
                        }
                      });
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * .4,
                      height: MediaQuery.sizeOf(context).height * .3,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: selectedColor2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            width: 87,
                            height: 97,
                            'assets/images/onboarding4.png',
                          ),
                          const Text(
                            'Conduct Waste Collection',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff8185FC),
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'For agents responsible for collecting plastic waste.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              CustomButton(
                text: "Next",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SignupScreen();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
