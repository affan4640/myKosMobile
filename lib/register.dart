import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat(reverse: true);

    _anim = Tween<double>(begin: -20, end: 20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF4E8),
      body: Stack(
        children: [
          // 🔥 BACKGROUND ANIMATION
          AnimatedBuilder(
            animation: _anim,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    top: -120 + _anim.value,
                    left: -100,
                    child: _circle(
                      350,
                      const Color(0xFFCBF3BB).withOpacity(0.4),
                    ),
                  ),
                  Positioned(
                    top: -80 - _anim.value,
                    right: -120,
                    child: _circle(
                      300,
                      const Color(0xFFABE7B2).withOpacity(0.4),
                    ),
                  ),
                ],
              );
            },
          ),

          // 🔥 CONTENT
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Register to get started",
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 30),

                    // 🔥 LOGO
                    Center(
                      child: Image.asset(
                        'assets/logo.png',
                        height: 160,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 30),

                    _input("Enter your name",
                        icon: Icons.person_outline),

                    const SizedBox(height: 15),

                    _input("Enter your email",
                        icon: Icons.email_outlined),

                    const SizedBox(height: 15),

                    _input("Enter your password",
                        icon: Icons.lock_outline, isPassword: true),

                    const SizedBox(height: 30),

                    // 🔥 REGISTER BUTTON
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFCBF3BB),
                            Color(0xFFABE7B2),
                          ],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🔥 BACK TO LOGIN
                    Center(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          "Already have an account? Sign In",
                          style: TextStyle(
                            color: Color(0xFF93BFC7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔵 Circle
  Widget _circle(double size, Color color) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  // 🔤 Input (reuse style login)
  Widget _input(String hint,
      {required IconData icon, bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}