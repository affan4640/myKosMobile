import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../models/kost_model.dart';
import '../search/search_screen.dart';
import '../payment/checkout_screen.dart';

class MyKostScreen extends StatefulWidget {
  const MyKostScreen({super.key});

  @override
  State<MyKostScreen> createState() => _MyKostScreenState();
}

class _MyKostScreenState extends State<MyKostScreen> {
  String _selectedFilter = 'Semua';
  final List<String> _filters = ['Semua', 'Aktif', 'Selesai'];

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> myKostsData = [
      {'kost': mockKosts[0], 'status': 'Aktif'},
      {'kost': mockKosts[2], 'status': 'Selesai'},
    ];

    final filteredKosts = _selectedFilter == 'Semua'
        ? myKostsData
        : myKostsData.where((k) => k['status'] == _selectedFilter).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Kost Saya',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: _filters.map((filter) {
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.grey.shade300,
                      ),
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: filteredKosts.isEmpty
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
                            'Kamu belum punya kos, temukan kos mu sekarang',
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: filteredKosts.length,
                    itemBuilder: (context, index) {
                      final item = filteredKosts[index];
                      final Kost kost = item['kost'];
                      final String statusText = item['status'];
                      final Color statusColor = statusText == 'Aktif'
                          ? Colors.green
                          : Colors.grey;

                      return Container(
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
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: statusColor.withAlpha(
                                            (0.1 * 255).round(),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          statusText,
                                          style: TextStyle(
                                            color: statusColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      PopupMenuButton<String>(
                                        icon: const Icon(
                                          Icons.more_vert,
                                          size: 20,
                                          color: AppColors.textSecondary,
                                        ),
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        onSelected: (value) {
                                          if (value == 'perpanjang') {
                                            // Arahkan ke halaman Checkout membawa data kost
                                            Get.to(
                                              () => CheckoutScreen(kost: kost),
                                            );
                                          } else if (value == 'ulasan') {
                                            int currentRating = 0;
                                            Get.dialog(
                                              Dialog(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: StatefulBuilder(
                                                  builder: (context, setStateDialog) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            24.0,
                                                          ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'Beri Ulasan',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 16,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: List.generate(5, (
                                                              index,
                                                            ) {
                                                              return IconButton(
                                                                onPressed: () {
                                                                  setStateDialog(
                                                                    () {
                                                                      currentRating =
                                                                          index +
                                                                          1;
                                                                    },
                                                                  );
                                                                },
                                                                icon: Icon(
                                                                  index <
                                                                          currentRating
                                                                      ? Icons
                                                                            .star
                                                                      : Icons
                                                                            .star_border,
                                                                  color: AppColors
                                                                      .warning,
                                                                  size: 36,
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                          const SizedBox(
                                                            height: 16,
                                                          ),
                                                          TextField(
                                                            maxLines: 3,
                                                            decoration: InputDecoration(
                                                              hintText:
                                                                  'Bagikan pengalaman Anda...',
                                                              hintStyle:
                                                                  const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                              border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      12,
                                                                    ),
                                                                borderSide: BorderSide(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300,
                                                                ),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      12,
                                                                    ),
                                                                borderSide:
                                                                    const BorderSide(
                                                                      color: AppColors
                                                                          .primary,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 24,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: OutlinedButton(
                                                                  style: OutlinedButton.styleFrom(
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            12,
                                                                          ),
                                                                    ),
                                                                    side: const BorderSide(
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                  onPressed: () =>
                                                                      Get.back(),
                                                                  child: const Text(
                                                                    'Batal',
                                                                    style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 12,
                                                              ),
                                                              Expanded(
                                                                child: ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                    backgroundColor:
                                                                        AppColors
                                                                            .primary,
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            12,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  onPressed: () {
                                                                    Get.back();
                                                                    Get.snackbar(
                                                                      'Sukses',
                                                                      'Terima kasih atas ulasan Anda!',
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green,
                                                                      colorText:
                                                                          Colors
                                                                              .white,
                                                                    );
                                                                  },
                                                                  child: const Text(
                                                                    'Kirim',
                                                                    style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        itemBuilder: (BuildContext context) => [
                                          const PopupMenuItem<String>(
                                            value: 'perpanjang',
                                            child: Text(
                                              'Perpanjang Sewa',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                          const PopupMenuItem<String>(
                                            value: 'ulasan',
                                            child: Text(
                                              'Beri Ulasan',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    kost.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
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
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
