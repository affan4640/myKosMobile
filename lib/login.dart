import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
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
          // 🔥 BACKGROUND CIRCLES
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
                      "Sign In Account",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Welcome back!",
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

                    _input("Enter your email",
                        icon: Icons.email_outlined),
                    const SizedBox(height: 15),
                    _input("Enter your password",
                        icon: Icons.lock_outline, isPassword: true),

                    const SizedBox(height: 10),

                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                          color: Color(0xFF93BFC7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 🔥 BUTTON LOGIN
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
                          "Sign In",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // 🔥 DIVIDER
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Or Sign In With",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 🔥 GOOGLE BUTTON
                    googleButton(),

                    const SizedBox(height: 30),

                    // 🔥 SIGN UP
                    const Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: "Don’t have an account? "),
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: Color(0xFF93BFC7),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
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

  // 🔤 Input
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

  // 🔥 GOOGLE BUTTON (FIXED)
  Widget googleButton() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: Row(
          children: [
            const SizedBox(width: 16),
            Image.asset(
              'assets/google.png',
              height: 22,
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Center(
                child: Text(
                  "Continue with Google",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }
}