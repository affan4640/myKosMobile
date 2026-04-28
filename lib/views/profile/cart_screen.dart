import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../payment/payment_method_screen.dart';
import '../../controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  final CartController controller = Get.put(CartController());

  CartScreen({super.key});

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
          'Keranjang Sewa',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shopping_cart_outlined,
                  size: 80,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Keranjang kamu masih kosong',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => Get.back(),
                  child: const Text(
                    'Cari Kost Sekarang',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(24.0),
          itemCount: controller.cartItems.length,
          itemBuilder: (context, index) {
            final item = controller.cartItems[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
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
                    child: Image.asset(
                      'assets/images/kamar_kost.jpg', // atau item.kost.imageUrl
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.kost.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => controller.removeItem(index),
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.kost.location,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Rp${item.kost.price} /bulan',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Durasi Control
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Durasi (Bulan):',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      controller.decrementDuration(index),
                                  child: const Icon(
                                    Icons.remove_circle_outline,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${item.duration}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () =>
                                      controller.incrementDuration(index),
                                  child: const Icon(
                                    Icons.add_circle_outline,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        if (controller.cartItems.isEmpty) return const SizedBox.shrink();

        return Container(
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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Pembayaran',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Rp${controller.totalPrice}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
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
                  onPressed: () => Get.to(
                    () => PaymentMethodScreen(
                      totalAmount: controller.totalPrice + 5000,
                    ),
                  ), // Tambah biaya admin
                  child: const Text(
                    'Checkout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
