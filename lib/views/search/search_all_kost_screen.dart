import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/kost_model.dart';
import '../../services/kost_service.dart';
import '../../theme/app_colors.dart';
import '../detail/detail_screen.dart';
import 'search_screen.dart';

class SearchAllKostScreen extends StatefulWidget {
  final String? initialQuery;
  final List<Kost>? initialResults;

  const SearchAllKostScreen({
    super.key,
    this.initialQuery,
    this.initialResults,
  });

  @override
  State<SearchAllKostScreen> createState() => _SearchAllKostScreenState();
}

class _SearchAllKostScreenState extends State<SearchAllKostScreen> {
  final KostService _kostService = KostService();
  final _searchController = TextEditingController();

  String _query = '';

  List<Kost> _baseKosts = const [];
  bool _isLoading = false;

  static const List<String> _facilityKeywords = [
    'Wi-Fi',
    'AC',
    'K. Mandi Dalam',
    'Dapur',
    'Parkir',
    'CCTV',
    'Keamanan 24 Jam',
    'Laundry',
  ];

  static String _compact(String s) =>
      s.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '');

  @override
  void initState() {
    super.initState();
    _baseKosts = widget.initialResults ?? const [];
    if (widget.initialResults == null) {
      _fetchAllKosts();
    }
    final q = widget.initialQuery?.trim();
    if (q != null && q.isNotEmpty) {
      _searchController.text = q;
      _query = q;
    }
  }

  @override
  void didUpdateWidget(covariant SearchAllKostScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialResults != widget.initialResults) {
      _baseKosts = widget.initialResults ?? const [];
      if (widget.initialResults == null) {
        _fetchAllKosts();
      }
    }

    final next = widget.initialQuery?.trim() ?? '';
    final prev = oldWidget.initialQuery?.trim() ?? '';
    if (next == prev) return;

    if (next.isEmpty) {
      _searchController.clear();
      if (_query.isNotEmpty) {
        setState(() {
          _query = '';
        });
      }
      return;
    }

    _searchController.text = next;
    if (_query != next) {
      setState(() {
        _query = next;
      });
    }
  }

  Future<void> _fetchAllKosts() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    try {
      final result = await _kostService.getProperties();
      if (!mounted) return;
      setState(() {
        _baseKosts = result;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  List<Kost> get _allKosts {
    return _baseKosts;
  }

  List<Kost> get _filteredKosts {
    final q = _query.trim().toLowerCase();

    final tokens = q.split(RegExp(r'\s+')).where((t) => t.isNotEmpty).toList();

    return _allKosts.where((kost) {
      if (tokens.isEmpty) return true;

      final haystackRaw = <String>[
        kost.name,
        kost.location,
        ..._facilityKeywords,
      ].join(' ').toLowerCase();

      final haystackCompact = _compact(haystackRaw);

      return tokens.every((token) {
        if (haystackRaw.contains(token)) return true;
        final compactToken = _compact(token);
        return compactToken.isNotEmpty &&
            haystackCompact.contains(compactToken);
      });
    }).toList();
  }

  void _applySearch() {
    setState(() {
      _query = _searchController.text;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filteredKosts;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Cari Kost',
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Search Bar (samakan dengan Home)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.05 * 255).round()),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    onChanged: (_) => _applySearch(),
                    onSubmitted: (_) => _applySearch(),
                    decoration: InputDecoration(
                      hintText: 'Cari lokasi, nama kost, atau fasilitas',
                      hintStyle: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                      border: InputBorder.none,
                      icon: const Icon(
                        Icons.search,
                        color: AppColors.textSecondary,
                      ),
                      suffixIcon: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Get.to(() => SearchScreen()),
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.tune,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : results.isEmpty
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
                          'Coba ubah kata kunci pencarianmu.',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final kost = results[index];
                      return _KostCard(
                        kost: kost,
                        onTap: () => Get.to(() => DetailScreen(kost: kost)),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _KostCard extends StatelessWidget {
  final Kost kost;
  final VoidCallback onTap;

  const _KostCard({required this.kost, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.02 * 255).round()),
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
              child: kost.imageUrl.startsWith('http')
                  ? Image.network(
                      kost.imageUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 120,
                        height: 120,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.image_not_supported),
                      ),
                    )
                  : Image.asset(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withAlpha((0.1 * 255).round()),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rp${kost.price}/bulan',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              kost.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
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
  }
}
