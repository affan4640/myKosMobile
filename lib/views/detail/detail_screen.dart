import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../models/kost_model.dart';
import '../payment/checkout_screen.dart';
import '../chat/chat_detail_screen.dart';
import '../../models/cart_item_model.dart';
import '../../controllers/cart_controller.dart';

class DetailScreen extends StatefulWidget {
  final Kost kost;

  const DetailScreen({super.key, required this.kost});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _currentImageIndex = 0;
  late final List<String> _gallery;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _gallery = [
      widget.kost.imageUrl,
      'assets/images/kamar_kost.jpg',
      'assets/images/kamar_kost.jpg',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final kost = widget.kost;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white.withAlpha((0.9 * 255).round()),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Get.back(),
                ),
              ),
            ),
            actions: [
              CircleAvatar(
                backgroundColor: Colors.white.withAlpha((0.9 * 255).round()),
                child: IconButton(
                  icon: const Icon(Icons.share, color: Colors.black, size: 20),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: Colors.white.withAlpha((0.9 * 255).round()),
                child: IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : Colors.black,
                    size: 20,
                  ),
              onPressed: () {
                setState(() => _isFavorite = !_isFavorite);
              },
                ),
              ),
              const SizedBox(width: 16),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemCount: _gallery.length,
                    itemBuilder: (context, index) {
                      final imagePath = _gallery[index];
                      if (imagePath.startsWith('http')) {
                        return Image.network(imagePath, fit: BoxFit.cover);
                      } else {
                        return Image.asset(imagePath, fit: BoxFit.cover);
                      }
                    },
                  ),
                  // Dot indicators
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _gallery.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: _currentImageIndex == index ? 24 : 8,
                          decoration: BoxDecoration(
                            color: _currentImageIndex == index
                                ? Colors.white
                                : Colors.white54,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kost.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 1.3),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withAlpha((0.15 * 255).round()),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: AppColors.warning, size: 14),
                            const SizedBox(width: 4),
                            Text('${kost.rating}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.warning)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('(120 ulasan)', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                      const SizedBox(width: 12),
                      Container(width: 4, height: 4, decoration: BoxDecoration(color: Colors.grey.shade400, shape: BoxShape.circle)),
                      const SizedBox(width: 12),
                      const Icon(Icons.location_on, color: AppColors.primary, size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          kost.location,
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Rp${kost.price}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary)),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(' /bulan', style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Icons Row (Simplified for boilerplate)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildFacilityIcon(Icons.wifi, 'Wi-Fi'),
                      _buildFacilityIcon(Icons.ac_unit, 'AC'),
                      _buildFacilityIcon(Icons.bathtub_outlined, 'K. Mandi\nDalam'),
                      _buildFacilityIcon(Icons.kitchen, 'Dapur'),
                      _buildFacilityIcon(Icons.local_parking, 'Parkir'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Deskripsi',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Kost nyaman dan bersih di lokasi strategis Setiabudi. Dekat MRT, minimarket, dan pusat perbelanjaan.',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),

                  Divider(color: Colors.grey.shade100, thickness: 8, height: 48),
                  _buildFasilitas(),

                  Divider(color: Colors.grey.shade100, thickness: 8, height: 48),
                  _buildPeraturan(),

                  Divider(color: Colors.grey.shade100, thickness: 8, height: 48),
                  _buildLokasi(),

                  Divider(color: Colors.grey.shade100, thickness: 8, height: 48),
                  _buildOwnerInfo(),

                  Divider(color: Colors.grey.shade100, thickness: 8, height: 48),
                  _buildUlasan(),

                  const SizedBox(height: 24), // Ruang ekstra
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              SizedBox(
                    height: 54,
                width: 60,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () => Get.to(() => const ChatDetailScreen()),
                  child: const Icon(
                    Icons.chat_bubble_outline,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 54,
                width: 60,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    final cartC = Get.put(CartController());
                    final exists = cartC.cartItems.any((item) => item.kost.id == kost.id);
                    if (exists) {
                      Get.snackbar(
                        'Info',
                        'Kost ini sudah ada di keranjang',
                        backgroundColor: Colors.blue,
                        colorText: Colors.white,
                      );
                    } else {
                      cartC.cartItems.add(CartItem(kost: kost, duration: 1));
                      Get.snackbar(
                        'Sukses',
                        'Kost berhasil ditambahkan ke keranjang',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    }
                  },
                  child: const Icon(Icons.add_shopping_cart, color: AppColors.primary),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                      height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                          elevation: 0,
                      shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () => Get.to(() => CheckoutScreen(kost: kost)),
                    child: const Text(
                      'Sewa Sekarang',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget _buildFacilityIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha((0.05 * 255).round()),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildFasilitas() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Fasilitas Lengkap'),
        const Text(
          'Fasilitas Kamar',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        _buildListItem(
          Icons.bed_outlined,
          'Kasur Springbed (Termasuk Bantal & Guling)',
        ),
        _buildListItem(Icons.ac_unit, 'AC & Kipas Angin'),
        _buildListItem(Icons.door_sliding_outlined, 'Lemari Pakaian 2 Pintu'),
        _buildListItem(Icons.desk, 'Meja & Kursi Belajar'),
        const SizedBox(height: 16),
        const Text(
          'Fasilitas Umum',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        _buildListItem(Icons.wifi, 'WiFi Kecepatan Tinggi 50 Mbps'),
        _buildListItem(Icons.kitchen_outlined, 'Dapur Bersama & Kulkas'),
        _buildListItem(
          Icons.local_parking_outlined,
          'Parkir Motor Luas & Aman',
        ),
      ],
    );
  }

  Widget _buildListItem(
    IconData icon,
    String title, {
    Color iconColor = AppColors.primary,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeraturan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Peraturan Kost'),
        _buildListItem(
          Icons.do_not_disturb_alt_outlined,
          'Tamu lawan jenis dilarang masuk kamar',
          iconColor: Colors.red,
        ),
        _buildListItem(
          Icons.access_time,
          'Akses gerbang ditutup maksimal jam 23:00',
          iconColor: Colors.red,
        ),
        _buildListItem(
          Icons.pets,
          'Dilarang membawa hewan peliharaan',
          iconColor: Colors.red,
        ),
        _buildListItem(
          Icons.smoking_rooms,
          'Dilarang merokok di dalam kawasan kost',
          iconColor: Colors.red,
        ),
      ],
    );
  }

  Widget _buildLokasi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Lokasi & Lingkungan Sekitar'),
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1524661135-423995f22d0b?auto=format&fit=crop&w=800&q=80',
              ), // Peta dummy
              fit: BoxFit.cover,
            ),
          ),
          child: const Center(
            child: Icon(Icons.location_on, size: 40, color: Colors.red),
          ),
        ),
        const SizedBox(height: 16),
        _buildPoiItem(Icons.school_outlined, 'Universitas Terdekat', '1.2 km'),
        _buildPoiItem(
          Icons.local_convenience_store_outlined,
          'Minimarket (Indomaret / Alfamart)',
          '200 m',
        ),
        _buildPoiItem(
          Icons.train_outlined,
          'Stasiun Kereta / Halte Bus',
          '800 m',
        ),
      ],
    );
  }

  Widget _buildPoiItem(IconData icon, String title, String distance) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha((0.1 * 255).round()),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          Text(
            distance,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOwnerInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Profil Tuan Kost'),
        Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=100&q=60',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bapak Budi Santoso',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Membalas dalam ± 10 menit',
                    style: TextStyle(
                      color: Colors.green.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUlasan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle('Ulasan Penyewa'),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Lihat Semua',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: AppColors.warning, size: 40),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '${widget.kost.rating}',
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, height: 1.0),
                    ),
                    const Text(
                      ' / 5.0',
                      style: TextStyle(fontSize: 16, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Berdasarkan 120 ulasan',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildReviewItem('Andi Saputra', 'Bulan lalu', 5, 'Kostnya sangat nyaman dan bersih. Fasilitas lengkap sesuai deskripsi. Ibu kost juga ramah.'),
        _buildReviewItem('Budi Santoso', '2 bulan lalu', 4, 'Lokasi strategis, gampang cari makan. Sayangnya parkiran motor agak sempit kalau malam.'),
      ],
    );
  }

  Widget _buildReviewItem(String name, String date, int rating, String review) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primary.withAlpha((0.1 * 255).round()),
                child: Text(name[0], style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(date, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (index) => Icon(index < rating ? Icons.star : Icons.star_border, color: AppColors.warning, size: 16)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(review, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4)),
        ],
      ),
    );
  }
}
