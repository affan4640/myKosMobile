import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_inputs.dart';
import '../../controllers/auth_controller.dart';

class OtpScreen extends StatelessWidget {
  final AuthController authC = Get.find<AuthController>();

  OtpScreen({super.key});

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
                    'Verifikasi OTP',
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
                'Masukkan Kode OTP ✉️',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Text(
                  'Kami telah mengirimkan 4 digit kode verifikasi ke email ${authC.recoveryEmail.value}.',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildOtpTextField(context, authC.otp1, true),
                  _buildOtpTextField(context, authC.otp2, false),
                  _buildOtpTextField(context, authC.otp3, false),
                  _buildOtpTextField(context, authC.otp4, false),
                ],
              ),

              const SizedBox(height: 32),
              Obx(
                () => PrimaryButton(
                  text: 'Verifikasi',
                  isLoading: authC.isLoading.value,
                  onPressed: () => authC.verifyOtp(),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tidak menerima kode? ',
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  GestureDetector(
                    onTap: () => authC.sendOtp(), // Resend OTP
                    child: Text(
                      'Kirim Ulang',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpTextField(
    BuildContext context,
    TextEditingController controller,
    bool autoFocus,
  ) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        controller: controller,
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
