import 'package:flutter/material.dart';
import 'package:wecollect/feature/auth/presentation/screen/login.dart';

import '../../feature/onboarding/screen/welcome.dart';
import '../../feature/reward/presentation/screen/reward_page.dart';

final Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: (context) => const WelcomeScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  RewardScreen.routeName: (context) => const RewardScreen(),
};
