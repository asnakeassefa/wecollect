import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'core/dj/injection.dart';
import 'core/utility/router.dart';
import 'feature/home/presentation/screen/dashboard.dart';

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
        fontFamily: 'Poppins',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(elevation: 0),
        ),
      ),
      routes: routes,
      home: const DashBoard(),
    );
  }
}
