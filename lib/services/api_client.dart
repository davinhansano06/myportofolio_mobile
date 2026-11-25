
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/education.dart';
import '../models/experience.dart';

class ApiClient {
  // Android Emulator mengakses komputer host melalui 10.0.2.2
  static const String baseUrl = 'http://10.0.2.2:8000/api/v1';

  static Future<List<Education>> getEducations() async {
    final response = await http.get(
      Uri.parse('$baseUrl/educations/'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Education.fromJson(json)).toList();
    }

    throw Exception('Failed to load educations: ${response.statusCode}');
  }

  static Future<Education> getEducationDetail(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/educations/$id/'),
    );

    if (response.statusCode == 200) {
      return Education.fromJson(jsonDecode(response.body));
    }

    throw Exception('Failed to load education detail: ${response.statusCode}');
  }

  static Future<List<Experience>> getExperiences() async {
    final response = await http.get(
      Uri.parse('$baseUrl/experiences/'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Experience.fromJson(json)).toList();
    }

    throw Exception('Failed to load experiences: ${response.statusCode}');
  }

  static Future<Experience> getExperienceDetail(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/experiences/$id/'),
    );

    if (response.statusCode == 200) {
      return Experience.fromJson(jsonDecode(response.body));
    }

    throw Exception('Failed to load experience detail: ${response.statusCode}');
  }

  static Future<Education> createEducation(
    Education education,
    String token,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/educations/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(education.toJson()),
    );

    if (response.statusCode == 201) {
      return Education.fromJson(jsonDecode(response.body));
    }

    throw Exception('Failed to create education: ${response.statusCode}');
  }
}
