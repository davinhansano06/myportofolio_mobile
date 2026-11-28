import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/education.dart';
import '../models/experience.dart';

class ApiException implements Exception {
  ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

class UnauthorizedException extends ApiException {
  UnauthorizedException([super.message = 'Unauthorized (401)'])
    : super(statusCode: 401);
}

class ApiClient {
  static String get baseUrl => ApiConfig.apiBaseUrl;

  static String _extractErrorMessage(http.Response response, String fallback) {
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        if (decoded['detail'] != null) {
          return decoded['detail'].toString();
        }
        final parts = <String>[];
        decoded.forEach((key, value) {
          if (value is List) {
            parts.add('$key: ${value.join(', ')}');
          } else {
            parts.add('$key: $value');
          }
        });
        if (parts.isNotEmpty) {
          return parts.join('\n');
        }
      }
    } catch (_) {
      // Ignore non-JSON error body and use fallback.
    }
    return '$fallback (${response.statusCode})';
  }

  static Future<List<Education>> getEducations({http.Client? client}) async {
    final httpClient = client ?? http.Client();
    try {
      final response = await httpClient.get(Uri.parse('$baseUrl/educations/'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data
            .map((json) => Education.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      throw ApiException(
        _extractErrorMessage(response, 'Gagal memuat data Education'),
        statusCode: response.statusCode,
      );
    } finally {
      if (client == null) {
        httpClient.close();
      }
    }
  }

  static Future<Education> getEducationDetail(
    String id, {
    http.Client? client,
  }) async {
    final httpClient = client ?? http.Client();
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/educations/$id/'),
      );

      if (response.statusCode == 200) {
        return Education.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      }

      throw ApiException(
        _extractErrorMessage(response, 'Gagal memuat detail Education'),
        statusCode: response.statusCode,
      );
    } finally {
      if (client == null) {
        httpClient.close();
      }
    }
  }

  static Future<Education> createEducation(
    Education education,
    String token, {
    http.Client? client,
  }) async {
    final httpClient = client ?? http.Client();
    try {
      final response = await httpClient.post(
        Uri.parse('$baseUrl/educations/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
        body: jsonEncode(education.toCreateJson()),
      );

      if (response.statusCode == 201) {
        return Education.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      }

      if (response.statusCode == 401) {
        throw UnauthorizedException();
      }

      throw ApiException(
        _extractErrorMessage(response, 'Gagal menambahkan Education'),
        statusCode: response.statusCode,
      );
    } finally {
      if (client == null) {
        httpClient.close();
      }
    }
  }

  static Future<List<Experience>> getExperiences({http.Client? client}) async {
    final httpClient = client ?? http.Client();
    try {
      final response = await httpClient.get(Uri.parse('$baseUrl/experiences/'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data
            .map((json) => Experience.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      throw ApiException(
        _extractErrorMessage(response, 'Gagal memuat data Proyek / Experience'),
        statusCode: response.statusCode,
      );
    } finally {
      if (client == null) {
        httpClient.close();
      }
    }
  }

  static Future<Experience> getExperienceDetail(
    String id, {
    http.Client? client,
  }) async {
    final httpClient = client ?? http.Client();
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/experiences/$id/'),
      );

      if (response.statusCode == 200) {
        return Experience.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      }

      throw ApiException(
        _extractErrorMessage(
          response,
          'Gagal memuat detail Proyek / Experience',
        ),
        statusCode: response.statusCode,
      );
    } finally {
      if (client == null) {
        httpClient.close();
      }
    }
  }

  static Future<Experience> createExperience(
    Experience experience,
    String token, {
    http.Client? client,
  }) async {
    final httpClient = client ?? http.Client();
    try {
      final response = await httpClient.post(
        Uri.parse('$baseUrl/experiences/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
        body: jsonEncode(experience.toCreateJson()),
      );

      if (response.statusCode == 201) {
        return Experience.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      }

      if (response.statusCode == 401) {
        throw UnauthorizedException();
      }

      throw ApiException(
        _extractErrorMessage(response, 'Gagal menambahkan Proyek / Experience'),
        statusCode: response.statusCode,
      );
    } finally {
      if (client == null) {
        httpClient.close();
      }
    }
  }
}
