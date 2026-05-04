import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthResult {
  final bool success;
  final String message;
  final String? token;
  AuthResult({required this.success, required this.message, this.token});
}

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final String _baseUrl = 'https://chess-gore-patience.ngrok-free.dev/api';
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'ngrok-skip-browser-warning': 'true',
  };

  String? _token;
  String? get token => _token;

  Future<void> saveUser(String token, String name, String email, String role, {String? phone}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('role', role);
    await prefs.setString('phone', phone ?? '');
    _token = token;
  }

  Future<Map<String, String?>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'token': prefs.getString('token'),
      'name':  prefs.getString('name'),
      'email': prefs.getString('email'),
      'role':  prefs.getString('role'),
      'phone': prefs.getString('phone'),
    };
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _token = null;
  }

  Future<AuthResult> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: _headers,
        body: jsonEncode({'email': email, 'password': password}),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await saveUser(
          data['token'],
          data['user']['name'],
          data['user']['email'],
          data['user']['role'] ?? 'tenant',
          phone: data['user']['phone'],
        );
        return AuthResult(success: true, message: data['message'] ?? 'Login berhasil', token: data['token']);
      } else {
        return AuthResult(success: false, message: data['message'] ?? 'Login gagal');
      }
    } catch (e) {
      return AuthResult(success: false, message: 'Terjadi kesalahan jaringan');
    }
  }

  Future<AuthResult> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: _headers,
        body: jsonEncode({'name': name, 'email': email, 'password': password, 'password_confirmation': password}),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return AuthResult(success: true, message: data['message'] ?? 'Pendaftaran berhasil');
      } else {
        return AuthResult(success: false, message: data['message'] ?? 'Pendaftaran gagal');
      }
    } catch (e) {
      return AuthResult(success: false, message: 'Terjadi kesalahan jaringan');
    }
  }

  Future<AuthResult> sendOtp(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/forgot-password'),
        headers: _headers,
        body: jsonEncode({'email': email}),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return AuthResult(success: true, message: data['message'] ?? 'OTP terkirim');
      } else {
        return AuthResult(success: false, message: data['message'] ?? 'Gagal kirim OTP');
      }
    } catch (e) {
      return AuthResult(success: false, message: 'Terjadi kesalahan jaringan');
    }
  }

  Future<AuthResult> verifyOtp(String email, String code) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/verify-otp'),
        headers: _headers,
        body: jsonEncode({'email': email, 'otp': code}),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return AuthResult(success: true, message: data['message'] ?? 'OTP terverifikasi');
      } else {
        return AuthResult(success: false, message: data['message'] ?? 'OTP tidak valid');
      }
    } catch (e) {
      return AuthResult(success: false, message: 'Terjadi kesalahan jaringan');
    }
  }

  Future<AuthResult> changePassword(String email, String newPassword) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/reset-password'),
        headers: _headers,
        body: jsonEncode({'email': email, 'password': newPassword, 'password_confirmation': newPassword}),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return AuthResult(success: true, message: data['message'] ?? 'Password berhasil diubah');
      } else {
        return AuthResult(success: false, message: data['message'] ?? 'Gagal ubah password');
      }
    } catch (e) {
      return AuthResult(success: false, message: 'Terjadi kesalahan jaringan');
    }
  }

  Future<void> logout() async {
    await clearUser();
  }
}