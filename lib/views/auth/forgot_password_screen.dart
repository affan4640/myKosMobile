import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_inputs.dart';
import '../../controllers/auth_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final AuthController authC = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Lupa Password',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/logos/logomykost.png', height: 120),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Lupa Password? 🔒',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Jangan khawatir! Masukkan alamat email yang terdaftar, kami akan mengirimkan kode OTP untuk memulihkan akses Anda.',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                controller: authC.forgotEmail,
                hint: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              Obx(
                () => PrimaryButton(
                  text: 'Kirim Kode OTP',
                  isLoading: authC.isLoading.value,
                  onPressed: () => authC.sendOtp(),
                ),
              ),
            ],
          ),
        ),
      ), // Penutup kurung untuk SafeArea yang sebelumnya hilang
    );
  }
}
