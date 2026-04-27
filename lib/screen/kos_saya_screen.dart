import 'package:flutter/material.dart';
import '../core/colors.dart';

class KosSayaScreen extends StatelessWidget {
  const KosSayaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Membuat AppBar rata dengan body
        centerTitle: true,
        title: const Text(
          "Kos Saya",
          style: TextStyle(
            color: MyKostColors.textDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0), // Padding di sekitar konten
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ilustrasi
              // Pastikan gambar sudah ada di folder assets dan didaftarkan di pubspec.yaml
              Image.asset(
                'assets/images/no_kost_illustration.png',
                width: 250, // Sesuaikan ukuran gambar
              ),
              const SizedBox(height: 32), // Jarak antara gambar dan teks
              // Teks Pesan
              const Text(
                "Kamu belum punya kos,\ntemukan kos mu sekarang",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: MyKostColors.textDark,
                  height: 1.5, // Menambah tinggi baris agar lebih mudah dibaca
                ),
              ),
              const SizedBox(height: 32), // Jarak antara teks dan tombol
              // Tombol "Cari Kos Sekarang"
              SizedBox(
                width: double.infinity, // Membuat tombol selebar padding
                height: 50, // Tinggi tombol
                child: ElevatedButton(
                  onPressed: () {
                    // Logika untuk navigasi ke halaman pencarian kos
                    // Contoh: Navigator.of(context).pushNamed('/cari_kos');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyKostColors.primary, // Menggunakan warna utama teal
                    elevation: 0, // Tombol rata tanpa bayangan
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Sudut tombol tumpul
                    ),
                  ),
                  child: const Text(
                    "Cari Kos Sekarang",
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
      // Bottom navigation handled by a top-level MainNavbar; no local bottomNav here.
    );
  }
}