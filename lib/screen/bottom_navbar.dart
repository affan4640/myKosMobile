import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'kos_saya_screen.dart';
import 'app_bottom_nav.dart';

class MainNavbar extends StatefulWidget {
  const MainNavbar({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<MainNavbar> createState() => _MainNavbarState();
}

class _MainNavbarState extends State<MainNavbar> {
  late int _currentIndex;

  // Daftar halaman yang akan ditampilkan saat menu di-klik
  final List<Widget> _pages = [
    const HomeScreen(),
    const KosSayaScreen(),
    const Center(child: Text("Halaman Chat")), // Dummy page
    const Center(child: Text("Halaman Profil")), // Dummy page
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Menampilkan halaman sesuai index
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
