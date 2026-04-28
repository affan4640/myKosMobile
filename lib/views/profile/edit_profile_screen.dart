import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Ubah Profil',
          style: TextStyle(
            color: Colors.black,
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
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/profiles/hana.jpg'),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            _buildInputField(
              'Nama Lengkap',
              'SAHRIL SIDIK',
              Icons.person_outline,
            ),
            const SizedBox(height: 16),
            _buildInputField(
              'Email',
              'sahrilwfc@email.com',
              Icons.email_outlined,
            ),
            const SizedBox(height: 16),
            _buildInputField(
              'Nomor Telepon',
              '081234567890',
              Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Get.back();
                  Get.snackbar(
                    'Sukses',
                    'Profil berhasil diperbarui',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                },
                child: const Text(
                  'Simpan Perubahan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    String placeholder,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextFormField(
            initialValue: placeholder,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.grey.shade600),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
