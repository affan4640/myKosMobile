import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../models/kost_model.dart';
import 'payment_method_screen.dart';

class CheckoutController extends GetxController {
  var duration = 1.obs; // durasi sewa dalam bulan

  void increment() => duration++;
  void decrement() {
    if (duration > 1) duration--;
  }
}

class CheckoutScreen extends StatelessWidget {
  final Kost kost;
  final CheckoutController controller = Get.put(CheckoutController());

  CheckoutScreen({super.key, required this.kost}) {
    // Reset state durasi setiap kali halaman ini dibuka
    controller.duration.value = 1;
  }

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
          'Ringkasan Pesanan',
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
            // Info Kost Card
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      kost.imageUrl,
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withAlpha(
                              (0.1 * 255).round(),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            kost.type,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          kost.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 14,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                kost.location,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Detail Sewa
            const Text(
              'Detail Sewa',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            // Tanggal Masuk (Simulasi)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.withAlpha((0.1 * 255).round()),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.blue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Tanggal Masuk',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '27 April 2026',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Ubah',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Durasi Sewa
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(
                            (0.1 * 255).round(),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.access_time,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Lama Sewa',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, size: 16),
                          color: AppColors.textSecondary,
                          onPressed: controller.decrement,
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(),
                        ),
                        Obx(
                          () => Text(
                            '${controller.duration.value} Bln',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, size: 16),
                          color: AppColors.primary,
                          onPressed: controller.increment,
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

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
              child: Obx(() {
                int total = kost.price * controller.duration.value;
                int adminFee = 5000;
                return Column(
                  children: [
                    _buildReceiptRow(
                      'Harga Sewa (${controller.duration.value} Bulan)',
                      'Rp$total',
                    ),
                    const SizedBox(height: 12),
                    _buildReceiptRow('Biaya Admin', 'Rp$adminFee'),
                    const SizedBox(height: 16),
                    Container(height: 1, color: Colors.grey.shade200),
                    const SizedBox(height: 16),
                    _buildReceiptRow(
                      'Total Pembayaran',
                      'Rp${total + adminFee}',
                      isTotal: true,
                    ),
                  ],
                );
              }),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                int finalTotal =
                    (kost.price * controller.duration.value) + 5000;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Tagihan',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Rp$finalTotal',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                );
              }),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  int finalTotal =
                      (kost.price * controller.duration.value) + 5000;
                  Get.to(() => PaymentMethodScreen(totalAmount: finalTotal));
                },
                child: const Text(
                  'Pilih Pembayaran',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String title, String amount, {bool isTotal = false}) {
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
          amount,
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
