import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../main_layout.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

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
        title: const Text(
          'Detail Pesanan',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Transaksi
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.withAlpha((0.1 * 255).round()),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Pembayaran Berhasil',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '27 April 2026, 14:30 WIB',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Info Kost
            const Text(
              'Informasi Kost',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/kamar_kost.jpg',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Kost Nyaman Setiabudi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Setiabudi, Jakarta Selatan',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '1 Bulan Sewa',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Rincian Pembayaran
            const Text(
              'Rincian Pembayaran',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildReceiptRow('Metode Pembayaran', 'BCA Virtual Account'),
                  const SizedBox(height: 12),
                  _buildReceiptRow('ID Transaksi', 'TRX-9876543210'),
                  const Divider(height: 24),
                  _buildReceiptRow('Harga Sewa (1 Bulan)', 'Rp1.800.000'),
                  const SizedBox(height: 8),
                  _buildReceiptRow('Biaya Admin', 'Rp5.000'),
                  const Divider(height: 24),
                  _buildReceiptRow(
                    'Total Pembayaran',
                    'Rp1.805.000',
                    isTotal: true,
                  ),
                ],
              ),
            ),
          ],
        ),
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
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 54,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.download_outlined),
                    label: const Text('Unduh Bukti'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      // Simulasi unduh
                      Get.snackbar(
                        'Mengunduh...',
                        'Bukti pembayaran sedang diproses.',
                        showProgressIndicator: true,
                        progressIndicatorBackgroundColor: AppColors.primary,
                        snackPosition: SnackPosition.BOTTOM,
                        margin: const EdgeInsets.all(16),
                      );
                      Future.delayed(const Duration(seconds: 2), () {
                        Get.back(); // Tutup snackbar loading
                        Get.snackbar(
                          'Berhasil',
                          'Bukti pembayaran berhasil diunduh.',
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.all(16),
                        );
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () => Get.offAll(() => MainLayout()),
                    child: const Text(
                      'Ke Beranda',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
      ],
    );
  }
}
