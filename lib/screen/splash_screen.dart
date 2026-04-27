import 'package:flutter/material.dart';
import 'package:flutter_mykost/screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Decor (Gunakan Image.asset jika ada gambar khusus background)
          Container(color: Colors.white),
          Center(
            child: Image.asset('assets/images/logo-mykost.png', width: 200),
          ),
        ],
      ),
    );
  }
}
