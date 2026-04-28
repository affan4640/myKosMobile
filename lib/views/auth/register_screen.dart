import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_inputs.dart';
import '../../controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                    'Daftar',
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

              CustomTextField(
                controller: authC.registerName,
                hint: 'Nama Lengkap',
                icon: Icons.person_outline,
              ),

              CustomTextField(
                controller: authC.registerEmail,
                hint: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: TextField(
                  controller: authC.registerPassword,
                  obscureText: !_showPassword,
                  style: const TextStyle(),
                  decoration: InputDecoration(
                    hintText: 'Password',
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
                  controller: authC.registerConfirmPassword,
                  obscureText: !_showConfirmPassword,
                  style: const TextStyle(),
                  decoration: InputDecoration(
                    hintText: 'Konfirmasi Password',
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

              const SizedBox(height: 8),

              Obx(
                () => PrimaryButton(
                  text: 'Daftar Sekarang',
                  isLoading: authC.isLoading.value,
                  onPressed: () => authC.register(),
                ),
              ),

              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.grey.shade300, thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Atau',
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Colors.grey.shade300, thickness: 1),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Column(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: Text(
                      'Daftar dengan Gmail',
                      style: const TextStyle(color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: Text(
                      'Daftar dengan Apple',
                      style: const TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah punya akun ? ',
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      'Masuk Sekarang',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
