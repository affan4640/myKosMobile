import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../models/kost_model.dart';
import '../detail/detail_screen.dart';
import '../notifications/notification_screen.dart';
import '../search/search_screen.dart';
import '../profile/cart_screen.dart';
import '../../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeC = Get.put(HomeController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: homeC.refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hallo, Selamat datang Sahril Sidik!',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Mau cari kost di mana hari ini?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            color: AppColors.textPrimary,
                          ),
                          onPressed: () => Get.to(() => CartScreen()),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.notifications_none,
                            color: AppColors.textPrimary,
                          ),
                          onPressed: () =>
                              Get.to(() => const NotificationScreen()),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Search Bar
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
                    readOnly: true,
                    onTap: () => Get.to(() => SearchScreen()),
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
                      suffixIcon: Container(
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
                const SizedBox(height: 24),

                // Banner
                const _PromoBanner(),
                const SizedBox(height: 30),

                // Categories
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  clipBehavior: Clip.none,
                  child: Obx(
                    () => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: homeC.categories.asMap().entries.map((entry) {
                        final index = entry.key;
                        final cat = entry.value;
                        return Padding(
                          padding: EdgeInsets.only(
                            right: index == homeC.categories.length - 1
                                ? 0
                                : 20.0,
                          ),
                          child: TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0.0, end: 1.0),
                            // Durasi ditambah berdasarkan urutan (index) agar muncul bergantian
                            duration: Duration(
                              milliseconds: 400 + (index * 200),
                            ),
                            curve: Curves.easeOutCubic,
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(
                                    0,
                                    20 * (1 - value),
                                  ), // Efek bergeser dari bawah ke atas
                                  child: child,
                                ),
                              );
                            },
                            child: _buildCategoryItem(
                              homeC,
                              cat['icon'],
                              cat['label'],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Recommendations Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Rekomendasi Kost',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.to(() => SearchScreen()),
                      child: const Text(
                        'Lihat Semua >',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Horizontal List of Kosts
                Obx(
                  () => SizedBox(
                    height: 280,
                    child: homeC.filteredKosts.isEmpty
                        ? const Center(
                            child: Text(
                              'Tidak ada kost untuk filter ini.',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: homeC.filteredKosts.length,
                            itemBuilder: (context, index) {
                              return _buildKostCard(homeC.filteredKosts[index]);
                            },
                          ),
                  ),
                ),

                // Nearby list
                _buildNearbyList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(HomeController homeC, IconData icon, String label) {
    final isSelected = homeC.selectedFilter.value == label;
    return GestureDetector(
      onTap: () => homeC.setFilter(label),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.grey.shade200,
              ),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : AppColors.textPrimary,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKostCard(Kost kost) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double cardHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : 280.0;
        final double imageHeight = (cardHeight * 0.54).clamp(110.0, 160.0);

        return GestureDetector(
          onTap: () => Get.to(() => DetailScreen(kost: kost)),
          child: Container(
            width: 220,
            height: cardHeight,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      child: Image.asset(
                        'assets/images/kamar_kost.jpg',
                        height: imageHeight,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 14,
                        child: Icon(
                          Icons.favorite_border,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    // Rating badge on image
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha((0.5 * 255).round()),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 12,
                              color: Color(0xFFFFD700),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${kost.rating}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Type badge moved above name
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withAlpha(
                              (0.06 * 255).round(),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            kost.type,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
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
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        // Location under name
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 14,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                kost.location,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Rp',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${kost.price}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '/bulan',
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
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
    );
  }

  Widget _buildNearbyList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Kost Terdekat dari Universitas',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => Get.to(() => SearchScreen()),
              child: const Text(
                'Lihat Semua >',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: nearbyKosts.length,
            itemBuilder: (context, index) => _buildKostCard(nearbyKosts[index]),
          ),
        ),
      ],
    );
  }
}

class _PromoBanner extends StatefulWidget {
  const _PromoBanner();

  @override
  State<_PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<_PromoBanner> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<String> _banners = [
    'assets/images/banner2.png',
    'assets/images/banner2.png',
    'assets/images/banner2.png',
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 7), (Timer timer) {
      if (_currentPage < _banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio:
              2.0, // Rasio lebar berbanding tinggi (ubah ke 16/9 jika gambar lebih tinggi)
          child: Listener(
            onPointerDown: (_) => _timer?.cancel(),
            onPointerUp: (_) => _startTimer(),
            onPointerCancel: (_) => _startTimer(),
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: _banners.length,
              itemBuilder: (context, index) {
                final imageUrl = _banners[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _banners.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? AppColors.primary
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
