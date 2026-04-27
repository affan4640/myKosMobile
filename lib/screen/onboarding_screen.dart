import 'package:flutter/material.dart';
import 'package:flutter_mykost/core/colors.dart';
import 'package:flutter_mykost/screen/login_screen.dart';
import 'package:flutter_mykost/screen/register_screen.dart';
import 'package:flutter_mykost/screen/bottom_navbar.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset('assets/images/onboarding_illustration.png'),
            SizedBox(height: 40),
            Text(
              "Cari dan temukan kos kesukaan mu\nlebih mudah disini",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: MyKostColors.textDark),
            ),
            Spacer(),
            // Tombol Langsung ke Beranda
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainNavbar()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyKostColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Langsung Ke beranda",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 15),
            // Baris Tombol Masuk & Daftar
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: MyKostColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Masuk",
                      style: TextStyle(color: MyKostColors.primary),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: MyKostColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Daftar",
                      style: TextStyle(color: MyKostColors.primary),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
