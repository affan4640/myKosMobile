import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../controllers/auth_controller.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Daftarkan AuthController lalu pindah ke Onboarding setelah 2.5 detik
    if (!Get.isRegistered<AuthController>()) {
      Get.put(AuthController(), permanent: true);
    }
    Future.delayed(const Duration(milliseconds: 2500), () {
      Get.offAll(() => const OnboardingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeOutCubic, // Efek pergerakan yang mulus (smooth)
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(
                0,
                50 * (1 - value),
              ), // Efek geser dari bawah ke atas (Slide Up)
              child: Opacity(
                opacity: value.clamp(
                  0.0,
                  1.0,
                ), // Mulai dari transparan ke solid (Fade In)
                child: child,
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logos/bglogomykost.png', height: 200),
            ],
          ),
        ),
      ),
    );
  }
}
