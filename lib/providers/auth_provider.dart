import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  String? _token;
  String? _username;

  String? get token => _token;
  String? get username => _username;
  bool get isAuthenticated => _token != null && _token!.isNotEmpty;

  Future<bool> login(String username, String password) async {
    final response = await _client.post(
      Uri.parse('${ApiConfig.apiBaseUrl}/auth/token/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final token = data['token'] as String?;
      if (token == null || token.isEmpty) {
        return false;
      }
      _token = token;
      _username = username;
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<void> logout() async {
    final currentToken = _token;
    try {
      if (currentToken != null && currentToken.isNotEmpty) {
        await _client.post(
          Uri.parse('${ApiConfig.apiBaseUrl}/auth/logout/'),
          headers: {'Authorization': 'Token $currentToken'},
        );
      }
    } catch (_) {
      // Tetap hapus token lokal meskipun request logout ke server gagal.
    } finally {
      _token = null;
      _username = null;
      notifyListeners();
    }
  }
}
