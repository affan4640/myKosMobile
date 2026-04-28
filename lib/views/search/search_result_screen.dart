// lib/views/search/search_result_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../models/kost_model.dart';
import '../detail/detail_screen.dart';

class SearchResultScreen extends StatefulWidget {
  final String location;
  final String type;
  final int minPrice;
  final int maxPrice;
  final List<String> facilities;

  const SearchResultScreen({
    super.key,
    required this.location,
    required this.type,
    required this.minPrice,
    required this.maxPrice,
    required this.facilities,
  });

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late String _selectedFilter;
  final List<String> _filters = [
    'Semua',
    'Terdekat',
    'Termurah',
    'Putra',
    'Putri',
    'Campuran',
  ];

  @override
  void initState() {
    super.initState();
    // Mengambil filter tipe kost awal dari layar pencarian sebelumnya
    _selectedFilter = widget.type;
  }

  @override
  Widget build(BuildContext context) {
    List<Kost> baseData = _selectedFilter == 'Terdekat'
        ? nearbyKosts
        : mockKosts;

    var results = baseData.where((kost) {
      final matchType =
          (_selectedFilter == 'Semua' ||
              _selectedFilter == 'Terdekat' ||
              _selectedFilter == 'Termurah')
          ? true
          : kost.type == _selectedFilter;
      final matchLocation =
          widget.location.isEmpty ||
          kost.location.toLowerCase().contains(widget.location.toLowerCase());
      final matchPrice =
          kost.price >= widget.minPrice && kost.price <= widget.maxPrice;

      return matchType && matchLocation && matchPrice;
    }).toList();

    if (_selectedFilter == 'Termurah') {
      results.sort((a, b) => a.price.compareTo(b.price));
    }

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
          'Hasil Pencarian',
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
            child: results.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Oops! Kost tidak ditemukan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Coba sesuaikan filter pencarianmu.',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final kost = results[index];
                      return GestureDetector(
                        onTap: () => Get.to(() => DetailScreen(kost: kost)),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
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
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(16),
                                ),
                                child: Image.asset(
                                  kost.imageUrl,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
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
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Rp${kost.price}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primary,
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
                              ),
                            ],
                          ),
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
