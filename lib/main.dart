import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'core/dj/injection.dart';
import 'feature/onboarding/onboarding/screen/onboarding.dart';

void main() async {
  await configureInjection(Environment.prod);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'We Collect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Onboarding(),
    );
  }
}
