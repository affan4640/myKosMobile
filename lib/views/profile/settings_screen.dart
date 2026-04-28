import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/theme_controller.dart';
import 'privacy_security_screen.dart';
import 'terms_conditions_screen.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsController settingsC = Get.put(SettingsController());
  final ThemeController themeC = Get.find<ThemeController>();

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Pengaturan',
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
          Obx(
            () => _buildSwitchTile(
              context,
              'Notifikasi',
              Icons.notifications_outlined,
              settingsC.isNotificationEnabled.value,
              (value) => settingsC.toggleNotification(value),
            ),
          ),
          Obx(
            () => _buildSwitchTile(
              context,
              'Mode Gelap',
              Icons.dark_mode_outlined,
              themeC.isDarkMode.value,
              (value) => themeC.toggleTheme(value),
            ),
          ),
          const SizedBox(height: 12),
          _buildMenuTile(
            context,
            'Bahasa',
            Icons.language,
            () => _showLanguageDialog(context),
            trailingText: 'Indonesia',
          ),
          _buildMenuTile(
            context,
            'Privasi & Keamanan',
            Icons.shield_outlined,
            () => Get.to(() => const PrivacySecurityScreen()),
          ),
          _buildMenuTile(
            context,
            'Syarat & Ketentuan',
            Icons.description_outlined,
            () => Get.to(() => const TermsConditionsScreen()),
          ),
          _buildMenuTile(context, 'Tentang Aplikasi', Icons.info_outline, () {
            showAboutDialog(
              context: context,
              applicationName: 'MyKost',
              applicationVersion: '1.0.0',
            );
          }, trailingText: 'v1.0.0'),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Pilih Bahasa',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Indonesia',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: const Icon(
                  Icons.check_circle,
                  color: AppColors.primary,
                ),
                onTap: () {
                  Get.updateLocale(const Locale('id', 'ID'));
                  Get.back();
                },
              ),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('English'),
                onTap: () {
                  Get.updateLocale(const Locale('en', 'US'));
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSwitchTile(
    BuildContext context,
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

  Widget _buildMenuTile(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap, {
    String? trailingText,
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
            color: AppColors.primary.withAlpha((0.1 * 255).round()),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
        trailing: trailingText != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    trailingText,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                ],
              )
            : const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: AppColors.textSecondary,
              ),
      ),
    );
  }
}
