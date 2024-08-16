
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'core/dj/injection.dart';
import 'core/utility/router.dart';
import 'feature/onboarding/screen/onboarding.dart';

void main() async {
  await configureInjection(Environment.prod);

  // var url = Uri.parse('ws://wasteplasticcollector.onrender.com/ws/notification/');

  // try {
  //   final channel = IOWebSocketChannel.connect(url);
  //   // Listen for incoming messages
  //   channel.stream.listen((data) {
  //     log('Received data: $data');
  //     // Process the received data (e.g., parse JSON, update UI)
  //   });
  //   // (Optional) Send a message to the serverclear
  //   channel.sink.add('Hello from Flutter!');
  // } catch (e) {
  //   log('Error connecting to WebSocket: $e');
  // }

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
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(elevation: 0),
        ),
      ),
      routes: routes,
      home: const Onboarding(),
    );
  }
}
