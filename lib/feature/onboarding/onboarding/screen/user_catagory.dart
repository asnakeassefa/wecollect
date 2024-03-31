import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

import '../../../../core/utility/widget/button.dart';

class UserCatagory extends StatefulWidget {
  static String routeName = '/user_catagory';
  final bool newAccount;
  const UserCatagory({super.key, required this.newAccount});

  @override
  State<UserCatagory> createState() => _UserCatagoryState();
}

class _UserCatagoryState extends State<UserCatagory> {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Choose your catagory',
                    style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Welcome back! please select your role',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * .43,
                    height: MediaQuery.sizeOf(context).height * .3,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 2, color: AppColors.secondaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          width: 87,
                          height: 97,
                          'assets/svg/onboarding2.svg',
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
                  Container(
                    width: MediaQuery.sizeOf(context).width * .4,
                    height: MediaQuery.sizeOf(context).height * .3,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 2, color: AppColors.secondaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          width: 87,
                          height: 97,
                          'assets/svg/onboarding2.svg',
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
                ],
              ),
              const SizedBox(height: 100),
              CustomButton(
                text: "Next",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
