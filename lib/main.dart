import 'package:flutter/material.dart';
import 'package:flutter_mykost/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyKost',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

// Note: the default MyHomePage widget from the template was intentionally
// removed to keep the entrypoint focused on the project screens. If you
// still need the demo counter page, it can be re-added.
