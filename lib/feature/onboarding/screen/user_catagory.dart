import 'package:flutter/material.dart';
import 'package:wecollect/core/utility/theme/theme.dart';
import 'package:wecollect/feature/onboarding/screen/individual_org_catagory.dart';

import '../../../core/utility/widget/button.dart';

class UserCatagory extends StatefulWidget {
  static String routeName = '/user_catagory';
  final bool newAccount;
  const UserCatagory({super.key, required this.newAccount});

  @override
  State<UserCatagory> createState() => _UserCatagoryState();
}

class _UserCatagoryState extends State<UserCatagory> {
  int selected = 0;
  List<String> role = ['client', 'agent'];
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
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .9,
                      child: Text(
                        textAlign: TextAlign.center,
                        'Choose your catagory',
                        style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * .9,
                      child: const Text(
                        'Welcome back! please select your role',
                        style: TextStyle(fontSize: 16),
                      ),
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
                        selected = 0;
                      });
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * .43,
                      height: MediaQuery.sizeOf(context).height * .32,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: selected == 0
                                ? AppColors.primaryColor
                                : Colors.grey.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            width: 87,
                            height: 97,
                            'assets/icons/client.png',
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
                        selected = 1;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      width: MediaQuery.sizeOf(context).width * .43,
                      height: MediaQuery.sizeOf(context).height * .32,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: selected == 1
                                ? AppColors.primaryColor
                                : Colors.grey.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            width: 87,
                            height: 97,
                            'assets/icons/agent.png',
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
                    return UserTypeCatagory(
                      role: role[selected],
                    );
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
