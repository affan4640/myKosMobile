import 'package:flutter/material.dart';
import 'package:flutter_mykost/core/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Masuk"), leading: BackButton()),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Image.asset('assets/images/logo-mykost.png', height: 80),
            SizedBox(height: 40),

            // --- Input Email (Sudah diubah) ---
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                hintText: "Masukkan email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(height: 20),
            // --- Input Kata Sandi ---
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: Icon(Icons.visibility_off_outlined),
                hintText: "Masukkan kata sandi",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (v) {}),
                    Text("Ingat Kata Sandi"),
                  ],
                ),
                TextButton(onPressed: () {}, child: Text("Lupa Kata Sandi?")),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyKostColors.primary,
                ),
                child: Text("Masuk", style: TextStyle(color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text("Atau"),
            ),
            // Social Login Buttons
            _socialButton("Masuk dengan Gmail", Icons.g_mobiledata),
            SizedBox(height: 10),
            _socialButton(
              "Masuk dengan Nomor HP",
              Icons.phone_outlined,
            ), // Ini opsional, bisa diganti kalau mau
            SizedBox(height: 10),
            _socialButton("Masuk dengan Apple", Icons.apple),
          ],
        ),
      ),
    );
  }

  Widget _socialButton(String text, IconData icon) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: MyKostColors.primary),
        label: Text(text, style: TextStyle(color: MyKostColors.primary)),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: MyKostColors.primary),
        ),
      ),
    );
  }
}
