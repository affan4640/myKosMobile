// lib/services/auth_service.dart
import 'dart:async';

class AuthResult {
  final bool success;
  final String message;
  final String? token;

  AuthResult({required this.success, required this.message, this.token});
}

/// Simple mock AuthService. Replace with real HTTP calls later.
class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  String? _token;

  bool _isEmailValid(String email) {
    final regex = RegExp(r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,4}$');
    return regex.hasMatch(email);
  }

  Future<AuthResult> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 700));
    if (!_isEmailValid(email)) {
      return AuthResult(success: false, message: 'Email tidak valid');
    }
    if (password.length < 6) {
      return AuthResult(success: false, message: 'Password minimal 6 karakter');
    }
    _token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
    return AuthResult(success: true, message: 'Login berhasil', token: _token);
  }

  Future<AuthResult> register(
    String name,
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(milliseconds: 700));
    if (name.isEmpty) {
      return AuthResult(success: false, message: 'Nama tidak boleh kosong');
    }
    if (!_isEmailValid(email)) {
      return AuthResult(success: false, message: 'Email tidak valid');
    }
    if (password.length < 6) {
      return AuthResult(success: false, message: 'Password minimal 6 karakter');
    }
    // In a real service you might return the created user or token
    return AuthResult(success: true, message: 'Pendaftaran berhasil');
  }

  Future<AuthResult> sendOtp(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!_isEmailValid(email)) {
      return AuthResult(success: false, message: 'Email tidak valid');
    }
    // Simulate sending OTP
    return AuthResult(
      success: true,
      message: 'Kode OTP telah dikirim ke $email',
    );
  }

  Future<AuthResult> verifyOtp(String email, String code) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!_isEmailValid(email)) {
      return AuthResult(success: false, message: 'Email tidak valid');
    }
    if (code.length != 4) {
      return AuthResult(success: false, message: 'Kode OTP harus 4 digit');
    }
    // Accept any 4-digit code in mock
    return AuthResult(success: true, message: 'OTP terverifikasi');
  }

  Future<AuthResult> changePassword(String email, String newPassword) async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (!_isEmailValid(email)) {
      return AuthResult(success: false, message: 'Email tidak valid');
    }
    if (newPassword.length < 6) {
      return AuthResult(success: false, message: 'Password minimal 6 karakter');
    }
    return AuthResult(success: true, message: 'Password berhasil diubah');
  }

  String? get token => _token;

  void logout() {
    _token = null;
  }
}
