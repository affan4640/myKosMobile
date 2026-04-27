import 'package:flutter/material.dart';
import '../core/colors.dart';
import 'bottom_navbar.dart';
import 'app_bottom_nav.dart';

class InformasiKostScreen extends StatelessWidget {
  const InformasiKostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: AppBottomNav(
        currentIndex: 0,
        onTap: (index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => MainNavbar(initialIndex: index)),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header gambar dan profil
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: Icon(Icons.image, size: 80, color: Colors.white),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.reply,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -30,
                  left: 20,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: const CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.grey,
                          backgroundImage: AssetImage(
                            'assets/images/placeholder_avatar.png',
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Pemilik Kos Kenanga",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: MyKostColors.primary),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.chat,
                                    size: 12,
                                    color: MyKostColors.primary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Tanya Pemilik",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: MyKostColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 45),

            // Info utama
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Kos Kenanga Pasar IV",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Rp. 750.000/bulan",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey, size: 16),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          "Jl. Bunga Wijaya Kusuma No. 12 Medan",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Kamar tersisa : 3",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),

            const Divider(height: 40, thickness: 5, color: Color(0xFFF5F5F5)),

            // Spesifikasi & Fasilitas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Spesifikasi & Fasilitas Kamar",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  _buildIconText(
                    Icons.straighten,
                    "3 x 4 Meter",
                    MyKostColors.primary,
                  ),
                  _buildIconText(
                    Icons.bed_outlined,
                    "Tempat Tidur",
                    MyKostColors.primary,
                  ),
                  _buildIconText(
                    Icons.door_sliding_outlined,
                    "Lemari",
                    MyKostColors.primary,
                  ),
                  _buildIconText(
                    Icons.shower_outlined,
                    "Kamar Mandi",
                    MyKostColors.primary,
                  ),
                  _buildIconText(Icons.ac_unit, "AC", MyKostColors.primary),
                  _buildIconText(
                    Icons.chair_outlined,
                    "Bantal",
                    MyKostColors.primary,
                  ),
                ],
              ),
            ),

            const Divider(height: 40, thickness: 5, color: Color(0xFFF5F5F5)),

            // Fasilitas kamar mandi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Fasilitas Kamar Mandi",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  _buildIconText(
                    Icons.wc,
                    "Kloset Duduk",
                    MyKostColors.primary,
                  ),
                  _buildIconText(Icons.shower, "Shower", MyKostColors.primary),
                ],
              ),
            ),

            const Divider(height: 40, thickness: 5, color: Color(0xFFF5F5F5)),

            // Peraturan khusus
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Peraturan Khusus Kos",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  _buildIconText(
                    Icons.people_outline,
                    "Maksimal 2 orang/kamar",
                    MyKostColors.primary,
                  ),
                  _buildIconText(
                    Icons.block,
                    "Tidak untuk pasutri",
                    MyKostColors.primary,
                  ),
                  _buildIconText(
                    Icons.schedule,
                    "Batas bertamu sampai pukul 23.00 WIB",
                    MyKostColors.primary,
                  ),
                  _buildIconText(
                    Icons.receipt_long,
                    "Tamu wajib lapor",
                    MyKostColors.primary,
                  ),
                  _buildIconText(
                    Icons.hotel,
                    "Tamu diperbolehkan menginap (tapi tidak diperbolehkan lawan jenis)",
                    MyKostColors.primary,
                  ),
                  _buildIconText(
                    Icons.watch_later_outlined,
                    "Penyewa kos diharuskan pulang sebelum pukul 24.00 WIB",
                    MyKostColors.primary,
                  ),
                  _buildIconText(
                    Icons.payments_outlined,
                    "Deposit Rp. 500.000\nDeposit akan dikembalikan di akhir waktu sewa jika tidak terdapat kerusakan pada kos",
                    MyKostColors.primary,
                  ),
                  _buildIconText(
                    Icons.pets,
                    "Tidak diperbolehkan membawa hewan peliharaan",
                    MyKostColors.primary,
                  ),
                ],
              ),
            ),

            const Divider(height: 40, thickness: 5, color: Color(0xFFF5F5F5)),

            // Review
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Review Kos",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      SizedBox(width: 5),
                      Text(
                        "4.9",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " ( 12 Ulasan )",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildReviewItem(
                    "Randy Pratama",
                    "10 Feb 2025",
                    "Kos Kenanga, kos yang nyaman lingkungan nya juga aman bersih, orang-orang sekitar juga ramah",
                  ),
                  const Divider(height: 30),
                  _buildReviewItem(
                    "Setia Pela",
                    "11 Okt 2025",
                    "Kos Kenanga, kos tersusun, ini terbaik yang pernah saya tinggali, cocok untuk mahasiswa harga terjangkau dengan fasilitas yang cukup lengkap",
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            const Divider(height: 30, thickness: 5, color: Color(0xFFF5F5F5)),

            // Lokasi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Lokasi Kos",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Map Placeholder",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 5,
                    children: [
                      _buildPoiItem(
                        Icons.mosque,
                        "Masjid Taqwa",
                        MyKostColors.primary,
                      ),
                      _buildPoiItem(
                        Icons.church,
                        "Gereja GBKP",
                        MyKostColors.primary,
                      ),
                      _buildPoiItem(
                        Icons.local_convenience_store,
                        "Alfamart",
                        MyKostColors.primary,
                      ),
                      _buildPoiItem(
                        Icons.school,
                        "Univ. Muhammadiyah",
                        MyKostColors.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Helper widgets
  Widget _buildIconText(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                height: 1.4,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(String name, String date, String review) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 15, backgroundColor: Colors.grey),
                const SizedBox(width: 10),
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            Text(
              date,
              style: const TextStyle(color: Colors.grey, fontSize: 11),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: List.generate(
            5,
            (index) => const Icon(Icons.star, color: Colors.amber, size: 14),
          ),
        ),
        const SizedBox(height: 8),
        Text(review, style: const TextStyle(fontSize: 13, height: 1.4)),
      ],
    );
  }

  Widget _buildPoiItem(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
