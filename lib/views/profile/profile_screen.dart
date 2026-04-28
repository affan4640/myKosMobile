import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../auth/login_screen.dart';
import 'edit_profile_screen.dart';
import 'transaction_history_screen.dart';
import 'help_center_screen.dart';
import '../favorite/favorite_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Akun Saya',
          style: const TextStyle(
            color: AppColors.textPrimary, // Warna sudah diatur di theme
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.primary,
                  backgroundImage: AssetImage('assets/profiles/hana.jpg'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'SAHRIL SIDIK',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'sahrilwfc@email.com',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),

            _buildMenuTile(
              Icons.person_outline,
              'Edit Profil',
              () => Get.to(
                () => const EditProfileScreen(),
                transition: Transition.fadeIn,
              ),
            ),
            _buildMenuTile(
              Icons.history,
              'Riwayat Transaksi',
              () => Get.to(
                () => const TransactionHistoryScreen(),
                transition: Transition.fadeIn,
              ),
            ),
            _buildMenuTile(
              Icons.favorite_border,
              'Favorit',
              () => Get.to(
                () => const FavoriteScreen(),
                transition: Transition.fadeIn,
              ),
            ),
            _buildMenuTile(
              Icons.settings_outlined,
              'Pengaturan',
              () =>
                  Get.to(() => SettingsScreen(), transition: Transition.fadeIn),
            ),
            _buildMenuTile(
              Icons.help_outline,
              'Pusat Bantuan',
              () => Get.to(
                () => const HelpCenterScreen(),
                transition: Transition.fadeIn,
              ),
            ),

            const SizedBox(height: 24),
            ListTile(
              onTap: () {
                Get.dialog(
                  Dialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red.withAlpha((0.1 * 255).round()),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.logout,
                              color: Colors.red,
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Keluar Akun',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Apakah Anda yakin ingin keluar dari akun ini?',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    side: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  onPressed: () => Get.back(),
                                  child: Text(
                                    'Batal',
                                    style: const TextStyle(
                                      color: AppColors
                                          .textSecondary, // Warna sudah diatur di theme
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () => Get.offAll(
                                    () => LoginScreen(),
                                    transition: Transition.fadeIn,
                                  ),
                                  child: Text(
                                    'Keluar',
                                    style: const TextStyle(
                                      color: Colors
                                          .white, // Warna sudah diatur di theme
                                      fontWeight: FontWeight.bold,
                                    ),
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
              },
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withAlpha((0.1 * 255).round()),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.logout, color: Colors.red),
              ),
              title: Text(
                'Keluar',
                style: const TextStyle(
                  color: Colors.red, // Warna sudah diatur di theme
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile(IconData icon, String title, VoidCallback onTap) {
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
            fontWeight: FontWeight.w600, // Warna sudah diatur di theme
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
