
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider extends ChangeNotifier {
  String? _token;
  String? _username;

  String? get token => _token;
  String? get username => _username;
  bool get isAuthenticated => _token != null;

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/v1/auth/token/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _token = data['token'];
      _username = username;
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<void> logout() async {
    if (_token != null) {
      await http.post(
        Uri.parse('http://10.0.2.2:8000/api/v1/auth/logout/'),
        headers: {'Authorization': 'Token $_token'},
      );
    }

    _token = null;
    _username = null;
    notifyListeners();
  }
}
