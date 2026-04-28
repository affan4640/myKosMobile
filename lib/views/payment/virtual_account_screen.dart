import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import 'payment_success_screen.dart';

class VirtualAccountScreen extends StatelessWidget {
  final int totalAmount;
  final String method;

  const VirtualAccountScreen({
    super.key,
    required this.totalAmount,
    required this.method,
  });

  @override
  Widget build(BuildContext context) {
    // Membuat nomor VA dummy (acak)
    final String vaNumber =
        '8077 ${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';

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
          'Pembayaran',
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
            // Countdown Timer (Dummy)
            Center(
              child: Column(
                children: [
                  const Text(
                    'Selesaikan pembayaran dalam',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '23:59:59',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Batas akhir: Besok, 14:30 WIB',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Metode Pembayaran
            const Text(
              'Metode Pembayaran',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                method,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Nomor Virtual Account
            const Text(
              'Nomor Virtual Account',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    vaNumber,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(text: vaNumber.replaceAll(' ', '')),
                      );
                      Get.snackbar(
                        'Berhasil',
                        'Nomor Virtual Account disalin',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        margin: const EdgeInsets.all(16),
                      );
                    },
                    child: const Row(
                      children: [
                        Text(
                          'Salin',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.copy, size: 16, color: AppColors.primary),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Total Pembayaran
            const Text(
              'Total Pembayaran',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rp$totalAmount',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(text: totalAmount.toString()),
                      );
                      Get.snackbar(
                        'Berhasil',
                        'Total pembayaran disalin',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        margin: const EdgeInsets.all(16),
                      );
                    },
                    child: const Row(
                      children: [
                        Text(
                          'Salin',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.copy, size: 16, color: AppColors.primary),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Cara Pembayaran Accordion
            const Text(
              'Cara Pembayaran',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: ExpansionTile(
                title: const Text(
                  'Instruksi Pembayaran',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                iconColor: AppColors.primary,
                collapsedIconColor: Colors.grey,
                childrenPadding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                children: [
                  Text(
                    '1. Buka aplikasi m-Banking atau kunjungi ATM terdekat.\n2. Pilih menu Transfer > Virtual Account.\n3. Masukkan nomor Virtual Account di atas.\n4. Pastikan nominal pembayaran sesuai dengan total tagihan.\n5. Konfirmasi pembayaran dan simpan bukti transaksi.',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
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
          child: SizedBox(
            height: 54,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                // Simulasi cek status pembayaran berhasil
                Get.dialog(
                  Dialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 32.0,
                        horizontal: 24.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withAlpha(
                                (0.1 * 255).round(),
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const CircularProgressIndicator(
                              color: AppColors.primary,
                              strokeWidth: 3,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Mengecek Status...',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Mohon tunggu sebentar',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  barrierDismissible: false,
                );
                Future.delayed(const Duration(seconds: 2), () {
                  Get.back();
                  Get.offAll(() => const PaymentSuccessScreen());
                });
              },
              child: const Text(
                'Cek Status Pembayaran',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
