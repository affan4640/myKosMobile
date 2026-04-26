import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'register.dart';
import 'dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name ?? '');

        if (uri.path == '/auth/callback') {
          return MaterialPageRoute(
            builder: (_) => AuthCallbackPage(),
          );
        }
        if (uri.path == '/dashboard') {
          return MaterialPageRoute(builder: (_) => DashboardPage());
        }
        if (uri.path == '/register') {
          return MaterialPageRoute(builder: (_) => RegisterPage());
        }
        return MaterialPageRoute(builder: (_) => LoginPage());
      },
    );
  }
}

class AuthCallbackPage extends StatefulWidget {
  @override
  State<AuthCallbackPage> createState() => _AuthCallbackPageState();
}

class _AuthCallbackPageState extends State<AuthCallbackPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleCallback();
    });
  }

  Future<void> _handleCallback() async {
    final uri = Uri.base;
    final token = uri.queryParameters['token'];
    final name = uri.queryParameters['name'];
    final email = uri.queryParameters['email'];
    final role = uri.queryParameters['role'];

    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      await prefs.setString('user_name', name ?? '');
      await prefs.setString('user_email', email ?? '');
      await prefs.setString('user_role', role ?? 'tenant');
    }

    if (mounted) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}