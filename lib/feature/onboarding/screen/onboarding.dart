import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wecollect/core/utility/theme/theme.dart';
import 'package:wecollect/feature/onboarding/screen/welcome.dart';

import '../../../core/dj/injection.dart';
import '../../auth/presentation/screen/login.dart';
import '../../home_page.dart';
import '../bloc/onboarding_cubit.dart';
import '../bloc/onboarding_state.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OnboardingCubit>()..isLoaded(),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is OnboardingLoaded) {
            return const LoginScreen();
          } else if (state is UserAuthenticated) {
            return const HomePage();
          } else if (state is OnboardingError) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is OnboardingLoading) {
            return const Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            );
          }
          return const PageScroller();
        },
      ),
    );
  }
}

class PageScroller extends StatefulWidget {
  const PageScroller({super.key});
  @override
  State<PageScroller> createState() => _PageScrollerState();
}

class _PageScrollerState extends State<PageScroller> {
  final controller = PageController(initialPage: 0);
  int idx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, WelcomeScreen.routeName);
                },
                child: Text(
                  'Skip',
                  style: TextStyle(color: AppColors.secondaryColor),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: PageView(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  idx = index;
                });
              },
              children: [
                onboardingPages(
                    Img: 'assets/images/onboarding1.png',
                    title: 'Welcome to Eskalate',
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    body:
                        "Find the location of the nearest dustbin in your area"),
                onboardingPages(
                    Img: 'assets/images/onboarding5.png',
                    title: 'Build Your Profile',
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    body:
                        'Discover exciting job opportunities, easily submit applications, and connect with potential employers for a seamless job search experience.'),
                onboardingPages(
                    Img: 'assets/images/onboarding3.png',
                    title: 'Take Assessment',
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    body:
                        'Discover exciting job opportunities, easily submit applications, and connect with potential employers for a seamless job search experience.'),
                onboardingPages(
                    Img: 'assets/images/onboarding4.png',
                    title: 'Get Gob Offer',
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    body:
                        'Discover exciting job opportunities, easily submit applications, and connect with potential employers for a seamless job search experience.'),
                onboardingPages(
                    Img: 'assets/images/onboarding5.png',
                    title: 'Get Gob Offer',
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    body:
                        'Discover exciting job opportunities, easily submit applications, and connect with potential employers for a seamless job search experience.'),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: controller,
            count: 5,
            onDotClicked: (index) => controller.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut),
            effect: ExpandingDotsEffect(
              expansionFactor: 4,
              activeDotColor: AppColors.primaryColor,
              dotColor: Colors.grey,
              dotHeight: 8,
              dotWidth: 8,
              spacing: 5,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              idx == 4
                  ? Navigator.pushNamed(context, WelcomeScreen.routeName)
                  : controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: Size(MediaQuery.sizeOf(context).width * 0.8, 50),
            ),
            child: Text(idx == 4 ? "Get Stated" : "Next",
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

class onboardingPages extends StatelessWidget {
  const onboardingPages({
    super.key,
    required this.Img,
    required this.title,
    required this.body,
    required this.onPressed,
  });

  final String Img;
  final String title;
  final String body;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(Img)),
                  const SizedBox(height: 30),
                  Text(
                    body,
                    style: TextStyle(
                        fontSize: 18, color: Colors.grey[600], height: 1.75),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
