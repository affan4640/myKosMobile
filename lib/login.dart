import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "MyKost",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              //logo
              Container(
                height: 120,
                width: 120,
                color: Colors.grey[300],
              ),

              SizedBox(height: 30),

              //email
              TextField(
                decoration: InputDecoration(
                  hintText: "Masukan nomor telepon/Email",
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 11),
                    child: FaIcon(FontAwesomeIcons.phone ,size: 20)
                    ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(height: 10),

              //password
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Masukan Sandi",
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: FaIcon(FontAwesomeIcons.lock), 
                  
                  ),
                  suffixIcon: Icon(Icons.visibility_off),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Lupa Kata Sandi?",
                  style: TextStyle(fontSize: 12),
                ),
              ),

              SizedBox(height: 20),

              //tombollogin
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.grey[300],
                  ),
                  child: Text("Masuk", style: TextStyle(color: Colors.black)),
                ),
              ),

              SizedBox(height: 10),

              //reister
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("Daftar", style: TextStyle(color: Colors.black)),
                ),
              ),

              SizedBox(height: 20),

              //sosmed
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.instagram),
                  SizedBox(width: 20),
                  FaIcon(FontAwesomeIcons.whatsapp),
                  SizedBox(width: 20),
                  FaIcon(FontAwesomeIcons.facebook),
                  SizedBox(width: 20)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}