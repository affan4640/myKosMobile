import 'package:flutter/material.dart';
import '../core/colors.dart';
import 'informasi_kost_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER (Logo & Notifikasi) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/logo-mykost.png', height: 40),
                      const SizedBox(width: 10),
                      const Text(
                        "MyKost",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: MyKostColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.notifications_none,
                    color: MyKostColors.textDark,
                    size: 28,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // --- JUDUL ---
              const Text(
                "Mudahnya ngekos",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: MyKostColors.textDark,
                ),
              ),
              const SizedBox(height: 15),

              // --- PENCARIAN 1 (Cari Kos disini) ---
              const Text(
                "Cari Kos disini",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Cari lokasi kos",
                        prefixIcon: const Icon(
                          Icons.search,
                          color: MyKostColors.primary,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: MyKostColors.textDark,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                    ),
                    child: const Text("Cari"),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // --- SECTION POPULER ---
              const Text(
                "Populer",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyKostColors.textDark,
                ),
              ),
              const SizedBox(height: 15),

              // Horizontal Scroll View untuk Kartu Kos
              SizedBox(
                height: 240,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildKosCard(
                      context,
                      "Kos Cendelier Putih",
                      "Jl. sei Putih No. 17",
                      "Rp. 1.200.000",
                      "Campuran",
                      4.9,
                    ),
                    _buildKosCard(
                      context,
                      "Kos Damai Sejuk",
                      "Jl. Ayahanda No. 8",
                      "Rp. 1.000.000",
                      "Campuran",
                      4.9,
                    ),
                    _buildKosCard(
                      context,
                      "Kos Putri Melati",
                      "Jl. Setia Budi",
                      "Rp. 600.000",
                      "Putri",
                      4.8,
                    ),
                  ],
                ),
              ),

              const Divider(height: 40, thickness: 1, color: Colors.blueGrey),

              // --- SECTION DEKAT UNIVERSITAS ---
              const Text(
                "Kos dekat Universitas",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyKostColors.textDark,
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  hintText: "Cari Universitas",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: MyKostColors.primary,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Horizontal Scroll View untuk Kartu Kos Universitas
              SizedBox(
                height: 240,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildKosCard(
                      context,
                      "Kos Bahagia",
                      "Jl. Jamin Ginting",
                      "Rp. 800.000",
                      "Campuran",
                      4.9,
                    ),
                    _buildKosCard(
                      context,
                      "Kos Senada",
                      "Jl. Dr. Mansyur",
                      "Rp. 1.500.000",
                      "Putri",
                      4.9,
                    ),
                  ],
                ),
              ),

              const Divider(height: 40, thickness: 1, color: Colors.blueGrey),

              // --- SECTION DEKAT STASIUN ---
              const Text(
                "Kos dekat Stasiun",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyKostColors.textDark,
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  hintText: "Cari Stasiun",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: MyKostColors.primary,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // List Vertical untuk Kos Dekat Stasiun (Karena bentuk kartunya lebar)
              _buildWideKosCard(
                context,
                "Kos Kenanga Pasar IV",
                "Jl. Bunga Wijaya Kusuma No. 12",
                "Rp. 750.000",
                "Putra",
                4.9,
              ),
              const SizedBox(height: 15),
              _buildWideKosCard(
                context,
                "Kos Cendana Central",
                "Jl. Bunga Cempaka No. 20",
                "Rp. 850.000",
                "Putra",
                4.9,
              ),
              const SizedBox(height: 15),
              _buildWideKosCard(
                context,
                "Kos Cemara",
                "Jl. Sembada Ujung No. 36",
                "Rp. 500.000",
                "Putra",
                4.9,
              ),

              const SizedBox(
                height: 80,
              ), // Ruang ekstra di bawah agar tidak tertutup navbar
            ],
          ),
        ),
      ),
    );
  }

  // --- KOMPONEN KARTU KOS (Kecil/Horizontal) ---
  Widget _buildKosCard(
    BuildContext context,
    String title,
    String location,
    String price,
    String type,
    double rating,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const InformasiKostScreen()),
      ),
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                'assets/images/kos.jpg',
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: type == "Putri"
                              ? Colors.pink[400]
                              : (type == "Putra"
                                    ? Colors.blue[400]
                                    : MyKostColors.primary),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          type,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          Text(
                            rating.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "$price/bulan",
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- KOMPONEN KARTU KOS LEBAR (Untuk list vertikal) ---
  Widget _buildWideKosCard(
    BuildContext context,
    String title,
    String location,
    String price,
    String type,
    double rating,
  ) {
    // Membungkus kartu dengan InkWell/GestureDetector agar bisa diklik
    return InkWell(
      onTap: () {
        // Navigasi ke halaman Informasi Kost saat kartu diklik
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InformasiKostScreen()),
        );
      },
      borderRadius: BorderRadius.circular(
        12,
      ), // Efek klik mengikuti bentuk kartu
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Gambar Lebih Lebar
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                'assets/images/kos.jpg',
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: type == "Putri"
                              ? Colors.pink[400]
                              : (type == "Putra"
                                    ? Colors.blue[400]
                                    : MyKostColors.primary),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          type,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            rating.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "$price/bulan",
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
