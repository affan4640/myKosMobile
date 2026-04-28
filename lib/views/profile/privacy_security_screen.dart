import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import 'profile_change_password_screen.dart';
import 'privacy_policy_screen.dart';
import '../../controllers/privacy_security_controller.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PrivacySecurityController controller = Get.put(
      PrivacySecurityController(),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Privasi & Keamanan',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSectionTitle('Keamanan Akun'),
          _buildMenuTile(
            'Ubah Password',
            Icons.lock_outline,
            () => Get.to(() => const ProfileChangePasswordScreen()),
          ),
          Obx(
            () => _buildSwitchTile(
              'Autentikasi Biometrik',
              Icons.fingerprint,
              controller.isBiometricEnabled.value,
              (value) => controller.toggleBiometric(value),
            ),
          ),
          Obx(
            () => _buildSwitchTile(
              'Kunci Aplikasi',
              Icons.lock_clock_outlined,
              controller.isAppLockEnabled.value,
              (value) => controller.toggleAppLock(value),
            ),
          ),
          const SizedBox(height: 24),

          _buildSectionTitle('Privasi Data'),
          _buildMenuTile(
            'Kebijakan Privasi',
            Icons.privacy_tip_outlined,
            () => Get.to(() => const PrivacyPolicyScreen()),
          ),
          _buildMenuTile(
            'Kelola Akses Perangkat',
            Icons.devices_other_outlined,
            () {},
          ),
          const SizedBox(height: 24),

          _buildSectionTitle('Lainnya'),
          _buildMenuTile(
            'Hapus Akun',
            Icons.delete_forever_outlined,
            () {
              Get.defaultDialog(
                title: 'Hapus Akun',
                middleText:
                    'Apakah Anda yakin ingin menghapus akun secara permanen? Tindakan ini tidak dapat dibatalkan.',
                textConfirm: 'Hapus',
                textCancel: 'Batal',
                confirmTextColor: Colors.white,
                buttonColor: Colors.red,
                cancelTextColor: AppColors.textPrimary,
              );
            },
            iconColor: Colors.red,
            textColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildMenuTile(
    String title,
    IconData icon,
    VoidCallback onTap, {
    Color iconColor = AppColors.primary,
    Color textColor = AppColors.textPrimary,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withAlpha((0.1 * 255).round()),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: textColor,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SwitchListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.primary,
        secondary: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha((0.1 * 255).round()),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
      ),
    );
  }
}
