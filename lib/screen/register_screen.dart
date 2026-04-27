import 'package:flutter/material.dart';
import '../core/colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar"), leading: BackButton()),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Image.asset('assets/images/logo-mykost.png', height: 60),
            SizedBox(height: 30),
            _buildTextField("Nama", "Masukkan nama lengkap"),
            SizedBox(height: 15),
            _buildTextField("Nomor Handphone", "Masukkan nomor handphone"),
            SizedBox(height: 15),
            _buildTextField("Email", "Masukkan alamat email"),
            SizedBox(height: 15),
            _buildTextField(
              "Kata Sandi",
              "Masukkan kata sandi",
              isPassword: true,
            ),
            SizedBox(height: 15),
            _buildTextField(
              "Ulangi Kata Sandi",
              "Masukkan ulang kata sandi",
              isPassword: true,
              isActive: true,
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyKostColors.primary,
                ),
                child: Text("Daftar", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 20),
            Text("Sudah punya akun? Masuk"),
            SizedBox(height: 40),
            Text(
              "Dengan mendaftar, saya menyetujui Kebijakan Privasi",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint, {
    bool isPassword = false,
    bool isActive = false,
  }) {
    return TextFormField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: isActive ? MyKostColors.primary : Colors.grey,
        ),
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isActive ? MyKostColors.primary : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyKostColors.primary, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: isPassword ? Icon(Icons.visibility_off_outlined) : null,
      ),
    );
  }
}
