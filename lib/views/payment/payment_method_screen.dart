import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import 'virtual_account_screen.dart';

class PaymentMethodScreen extends StatefulWidget {
  final int totalAmount;

  const PaymentMethodScreen({super.key, required this.totalAmount});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedMethod = 'BCA Virtual Account'; // Default selection

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
          'Metode Pembayaran',
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
            // Order Summary Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha((0.05 * 255).round()),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primary.withAlpha((0.1 * 255).round()),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Pembayaran',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rp${widget.totalAmount}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Detail',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            const Text(
              'Transfer Virtual Account',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildPaymentOption(
              'BCA Virtual Account',
              'Dicek otomatis, bebas biaya',
              Icons.account_balance,
              Colors.blue.shade700,
            ),
            _buildPaymentOption(
              'Mandiri Virtual Account',
              'Dicek otomatis',
              Icons.account_balance,
              Colors.yellow.shade700,
            ),
            _buildPaymentOption(
              'BNI Virtual Account',
              'Dicek otomatis',
              Icons.account_balance,
              Colors.orange.shade700,
            ),

            const SizedBox(height: 24),
            const Text(
              'E-Wallet',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildPaymentOption(
              'GoPay',
              'Biaya admin Rp 1.000',
              Icons.account_balance_wallet,
              Colors.green,
            ),
            _buildPaymentOption(
              'OVO',
              'Biaya admin Rp 1.000',
              Icons.account_balance_wallet,
              Colors.purple,
            ),
            _buildPaymentOption(
              'Dana',
              'Biaya admin Rp 1.000',
              Icons.account_balance_wallet,
              Colors.blue.shade400,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Pembayaran',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Rp${widget.totalAmount}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    // Simulasi proses membuat Virtual Account
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
                                'Memproses...',
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
                    Future.delayed(const Duration(seconds: 1), () {
                      Get.back(); // Tutup loading
                      Get.to(
                        () => VirtualAccountScreen(
                          totalAmount: widget.totalAmount,
                          method: selectedMethod,
                        ),
                      );
                    });
                  },
                  child: const Text(
                    'Bayar Sekarang',
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
      ),
    );
  }

  Widget _buildPaymentOption(
    String title,
    String subtitle,
    IconData icon,
    Color iconColor,
  ) {
    bool isSelected = selectedMethod == title;
    return GestureDetector(
      onTap: () => setState(() => selectedMethod = title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withAlpha((0.05 * 255).round())
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withAlpha((0.1 * 255).round()),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w600,
                      fontSize: 15,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey.shade300,
                  width: 2,
                ),
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
