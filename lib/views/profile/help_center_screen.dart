import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Pusat Bantuan',
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                style: const TextStyle(),
                decoration: InputDecoration(
                  hintText: 'Cari topik bantuan...',
                  hintStyle: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: AppColors.textSecondary),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  'Pertanyaan Populer (FAQ)',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                _buildFaqItem(
                  'Bagaimana cara menyewa kos?',
                  'Anda dapat mencari kos yang diinginkan, masuk ke halaman detail, lalu klik tombol "Hubungi Pemilik" atau "Sewa Sekarang" untuk melanjutkan ke proses pembayaran.',
                ),
                _buildFaqItem(
                  'Apakah bisa membatalkan pesanan?',
                  'Pembatalan pesanan dapat dilakukan maksimal 1x24 jam setelah pembayaran berhasil, sesuai dengan kebijakan masing-masing pemilik kos.',
                ),
                _buildFaqItem(
                  'Metode pembayaran apa saja yang tersedia?',
                  'Kami menerima pembayaran melalui Transfer Bank (Virtual Account) dan beberapa layanan E-Wallet seperti GoPay, OVO, dan Dana.',
                ),
                _buildFaqItem(
                  'Bagaimana jika pemilik kos tidak membalas chat?',
                  'Jika pemilik kos tidak merespons dalam 1x24 jam, Anda dapat menekan tombol "Laporkan Kendala" atau menghubungi layanan Customer Service kami.',
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 54,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: AppColors.primary.withAlpha((0.5 * 255).round()),
                ),
                backgroundColor: AppColors.primary.withAlpha(
                  (0.05 * 255).round(),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: const Icon(Icons.support_agent, color: AppColors.primary),
              label: Text(
                'Hubungi Customer Service',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        iconColor: AppColors.primary,
        collapsedIconColor: Colors.grey,
        childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        children: [
          Text(
            answer,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
