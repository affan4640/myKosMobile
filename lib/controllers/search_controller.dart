import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../views/search/search_result_screen.dart';

class SearchKostController extends GetxController {
  final locationController = TextEditingController();

  final selectedType = 'Semua'.obs;
  final kostTypes = ['Semua', 'Putra', 'Putri', 'Campuran'];

  final priceRange = const RangeValues(500000, 3000000).obs;

  final facilities = [
    'Wi-Fi',
    'AC',
    'K. Mandi Dalam',
    'Dapur',
    'Parkir',
    'CCTV',
    'Keamanan 24 Jam',
    'Laundry',
  ];
  final selectedFacilities = <String>['Wi-Fi', 'AC', 'K. Mandi Dalam'].obs;

  @override
  void onClose() {
    locationController.dispose();
    super.onClose();
  }

  void resetFilters() {
    locationController.clear();
    selectedType.value = 'Semua';
    priceRange.value = const RangeValues(500000, 3000000);
    selectedFacilities.clear();
  }

  void toggleFacility(String facility, bool isSelected) {
    if (isSelected) {
      selectedFacilities.add(facility);
    } else {
      selectedFacilities.remove(facility);
    }
  }

  void applyFilters() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  const SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 4,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha((0.1 * 255).round()),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.home_work_rounded,
                      color: AppColors.primary,
                      size: 32,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'Menerapkan Filter...',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Mencari kost yang sesuai',
                style: GoogleFonts.poppins(
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

    Future.delayed(const Duration(milliseconds: 1500), () {
      Get.back(); // Tutup dialog loading
      Get.to(
        () => SearchResultScreen(
          location: locationController.text.trim(),
          type: selectedType.value,
          minPrice: priceRange.value.start.toInt(),
          maxPrice: priceRange.value.end.toInt(),
          facilities: selectedFacilities.toList(),
        ),
      );
    });
  }
}
