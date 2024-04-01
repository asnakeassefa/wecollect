import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'core/dj/injection.dart';
import 'core/utility/router.dart';
import 'feature/auth/presentation/screen/forgot.dart';
import 'feature/auth/presentation/screen/login.dart';
import 'feature/auth/presentation/screen/reset.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(elevation: 0),
        ),
      ),
      routes: routes,
      home: const ResetPassword(),
    );
  }
}
