import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/kost_model.dart';

class KostService {
  static final KostService _instance = KostService._internal();
  factory KostService() => _instance;
  KostService._internal();

  final String _baseUrl = 'https://chess-gore-patience.ngrok-free.dev/api';
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'ngrok-skip-browser-warning': 'true',
  };

  Future<Map<String, String>> _authHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    return {..._headers, 'Authorization': 'Bearer $token'};
  }

  Future<List<Kost>> getProperties({String? type, String? search}) async {
    try {
      final headers = await _authHeaders();
      final params = <String, String>{};
      if (type != null && type != 'Semua') params['type'] = type;
      if (search != null && search.isNotEmpty) params['search'] = search;

      final uri = Uri.parse(
        '$_baseUrl/properties',
      ).replace(queryParameters: params);
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) => Kost.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>?> getPropertyDetail(int id) async {
    try {
      final headers = await _authHeaders();
      final response = await http.get(
        Uri.parse('$_baseUrl/properties/$id'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getMyContracts() async {
    try {
      final headers = await _authHeaders();
      final response = await http.get(
        Uri.parse('$_baseUrl/my-contracts'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}