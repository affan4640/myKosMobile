import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_inputs.dart';
import '../../controllers/auth_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final AuthController authC = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());

  bool _showPassword = false;
  bool _showConfirmPassword = false;

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
                    'Ubah Password',
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
                'Ubah Password',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Hampir selesai! Silakan buat password baru Anda yang unik dan mudah diingat untuk mengamankan akun.',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: TextField(
                  controller: authC.newPassword,
                  obscureText: !_showPassword,
                  style: const TextStyle(),
                  decoration: InputDecoration(
                    hintText: 'Password Baru',
                    hintStyle: TextStyle(
                      color: AppColors.textSecondary.withAlpha(
                        (0.5 * 255).round(),
                      ),
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: AppColors.textSecondary,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () =>
                          setState(() => _showPassword = !_showPassword),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: TextField(
                  controller: authC.confirmNewPassword,
                  obscureText: !_showConfirmPassword,
                  style: const TextStyle(),
                  decoration: InputDecoration(
                    hintText: 'Konfirmasi Password Baru',
                    hintStyle: TextStyle(
                      color: AppColors.textSecondary.withAlpha(
                        (0.5 * 255).round(),
                      ),
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(
                      Icons.lock_reset_outlined,
                      color: AppColors.textSecondary,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () => setState(
                        () => _showConfirmPassword = !_showConfirmPassword,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => PrimaryButton(
                  text: 'Simpan Password Baru',
                  isLoading: authC.isLoading.value,
                  onPressed: () => authC.changePassword(),
                ),
              ),
            ],
          ),
        ),
      ), // Penutup kurung untuk SafeArea yang sebelumnya hilang
    );
  }
}
