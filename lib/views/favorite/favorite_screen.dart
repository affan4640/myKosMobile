import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../search/search_screen.dart';
import '../../controllers/favorite_controller.dart';
import '../detail/detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController controller = Get.put(FavoriteController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Favorit Saya',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(
            () => controller.favorites.isNotEmpty
                ? PopupMenuButton<String>(
                    icon: const Icon(Icons.sort, color: AppColors.textPrimary),
                    onSelected: (value) => controller.sortFavorites(value),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'Terbaru',
                        child: Text(
                          'Terbaru',
                          style: TextStyle(
                            fontWeight:
                                controller.selectedSort.value == 'Terbaru'
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: controller.selectedSort.value == 'Terbaru'
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'Termurah',
                        child: Text(
                          'Termurah',
                          style: TextStyle(
                            fontWeight:
                                controller.selectedSort.value == 'Termurah'
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: controller.selectedSort.value == 'Termurah'
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: Obx(
        () => controller.favorites.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/no_kost_illustration.png',
                        width: 260,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Kamu belum punya favorit, temukan kos yang kamu suka',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => Get.to(() => SearchScreen()),
                          child: const Text(
                            'Cari Kos Sekarang',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: controller.favorites.length,
                itemBuilder: (context, index) {
                  final kost = controller.favorites[index];
                  return Dismissible(
                    key: Key(kost.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      color: Colors.red,
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      return await Get.dialog<bool>(
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
                                    color: Colors.red.withAlpha(
                                      (0.1 * 255).round(),
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                    size: 32,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Hapus Favorit',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Apakah Anda yakin ingin menghapus kost ini dari daftar favorit?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
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
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          side: BorderSide(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        onPressed: () =>
                                            Get.back(result: false),
                                        child: const Text(
                                          'Batal',
                                          style: TextStyle(
                                            color: AppColors.textSecondary,
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
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          elevation: 0,
                                        ),
                                        onPressed: () => Get.back(result: true),
                                        child: const Text(
                                          'Hapus',
                                          style: TextStyle(
                                            color: Colors.white,
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
                    onDismissed: (direction) {
                      controller.removeFavorite(kost.id);
                      Get.snackbar(
                        'Berhasil',
                        '${kost.name} dihapus dari favorit',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        margin: const EdgeInsets.all(16),
                      );
                    },
                    child: GestureDetector(
                      onTap: () => Get.to(() => DetailScreen(kost: kost)),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(
                                (0.02 * 255).round(),
                              ),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                kost.imageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          kost.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        size: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          kost.location,
                                          style: const TextStyle(
                                            color: AppColors.textSecondary,
                                            fontSize: 11,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Rp${kost.price}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 14,
                                            color: AppColors.warning,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${kost.rating}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
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
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
