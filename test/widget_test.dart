import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/config/api_config.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/models/education.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/providers/auth_provider.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  group('ApiConfig', () {
    test('defaults to Android Emulator localhost URL', () {
      expect(ApiConfig.baseUrl, 'http://10.0.2.2:8000');
      expect(ApiConfig.apiBaseUrl, 'http://10.0.2.2:8000/api/v1');
    });
  });

  group('Models JSON serialization', () {
    test('Experience fromJson and toCreateJson match Django serializer', () {
      final exp = Experience.fromJson({
        'id': '12345678-1234-5678-1234-567812345678',
        'title': 'Portfolio Mobile',
        'institution': 'Universitas Indonesia',
        'period': '2025 - 2026',
        'description': 'Flutter mobile app for PBP.',
        'image': 'https://example.com/app.png',
        'star_count': 3,
        'is_starred': true,
      });

      expect(exp.id, '12345678-1234-5678-1234-567812345678');
      expect(exp.title, 'Portfolio Mobile');
      expect(exp.starCount, 3);
      expect(exp.isStarred, isTrue);

      final payload = exp.toCreateJson();
      expect(payload, {
        'title': 'Portfolio Mobile',
        'institution': 'Universitas Indonesia',
        'period': '2025 - 2026',
        'description': 'Flutter mobile app for PBP.',
        'image': 'https://example.com/app.png',
      });
    });

    test('Education fromJson and toCreateJson match Django serializer', () {
      final edu = Education.fromJson({
        'id': 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        'institution': 'Universitas Indonesia',
        'degree': 'S1 Sistem Informasi',
        'period': '2025 - 2029',
        'location': 'Depok',
        'skills': 'Flutter, Django',
        'is_current': true,
        'logo': 'img/uiputih.png',
        'star_count': 2,
        'is_starred': false,
        'starred_by_names': 'alice, bob',
      });

      expect(edu.institution, 'Universitas Indonesia');
      expect(edu.isCurrent, isTrue);
      expect(edu.starCount, 2);

      final payload = edu.toCreateJson();
      expect(payload, {
        'institution': 'Universitas Indonesia',
        'degree': 'S1 Sistem Informasi',
        'period': '2025 - 2029',
        'location': 'Depok',
        'skills': 'Flutter, Django',
        'is_current': true,
        'logo': 'img/uiputih.png',
      });
    });
  });

  group('AuthProvider', () {
    test(
      'login stores token and logout clears token even if server fails',
      () async {
        final mockClient = MockClient((request) async {
          if (request.url.path.endsWith('/auth/token/')) {
            return http.Response(
              jsonEncode({'token': 'secret-token-123'}),
              200,
            );
          }
          if (request.url.path.endsWith('/auth/logout/')) {
            throw Exception('Network unreachable');
          }
          return http.Response('Not found', 404);
        });

        final auth = AuthProvider(client: mockClient);
        expect(auth.isAuthenticated, isFalse);

        final success = await auth.login('owner', 'password123');
        expect(success, isTrue);
        expect(auth.isAuthenticated, isTrue);
        expect(auth.token, 'secret-token-123');
        expect(auth.username, 'owner');

        await auth.logout();
        expect(auth.isAuthenticated, isFalse);
        expect(auth.token, isNull);
        expect(auth.username, isNull);
      },
    );
  });

  group('ApiClient', () {
    test(
      'createExperience sends Token header and parses 201 response',
      () async {
        String? capturedAuthHeader;
        final mockClient = MockClient((request) async {
          capturedAuthHeader = request.headers['Authorization'];
          return http.Response(
            jsonEncode({
              'id': '11111111-1111-1111-1111-111111111111',
              'title': 'New Project',
              'institution': 'UI',
              'period': '2026',
              'description': 'Built with Flutter',
              'image': 'https://example.com/img.png',
              'star_count': 0,
              'is_starred': false,
            }),
            201,
          );
        });

        final created = await ApiClient.createExperience(
          Experience(
            title: 'New Project',
            institution: 'UI',
            period: '2026',
            description: 'Built with Flutter',
            image: 'https://example.com/img.png',
          ),
          'my-token',
          client: mockClient,
        );

        expect(capturedAuthHeader, 'Token my-token');
        expect(created.id, '11111111-1111-1111-1111-111111111111');
        expect(created.title, 'New Project');
      },
    );

    test('createExperience throws UnauthorizedException on 401', () async {
      final mockClient = MockClient(
        (_) async =>
            http.Response(jsonEncode({'detail': 'Invalid token.'}), 401),
      );

      expect(
        () => ApiClient.createExperience(
          Experience(title: 'Test', description: 'Desc'),
          'expired-token',
          client: mockClient,
        ),
        throwsA(isA<UnauthorizedException>()),
      );
    });
  });

  group('Widget navigation and route guards', () {
    testWidgets('Home page renders publicly without login', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      expect(find.text('MyPortfolio'), findsOneWidget);
      expect(find.text('Lihat Education'), findsOneWidget);
      expect(find.text('Lihat Proyek'), findsOneWidget);
      expect(find.text('Tambah Proyek'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets(
      'Direct navigation to ProjectFormPage redirects to LoginScreen',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          ChangeNotifierProvider(
            create: (_) => AuthProvider(),
            child: const MaterialApp(home: ProjectFormPage()),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(LoginScreen), findsOneWidget);
        expect(find.text('Login MyPortfolio'), findsOneWidget);
      },
    );

    testWidgets(
      'Tapping Tambah Proyek while logged out opens LoginScreen and continues after login',
      (WidgetTester tester) async {
        final mockClient = MockClient((request) async {
          if (request.url.path.endsWith('/auth/token/')) {
            return http.Response(jsonEncode({'token': 'valid-token'}), 200);
          }
          return http.Response('Not found', 404);
        });

        final auth = AuthProvider(client: mockClient);
        await tester.pumpWidget(MyApp(authProvider: auth));

        await tester.tap(find.text('Tambah Proyek'));
        await tester.pumpAndSettle();

        expect(find.byType(LoginScreen), findsOneWidget);

        final fields = find.byType(TextField);
        await tester.enterText(fields.at(0), 'owner');
        await tester.enterText(fields.at(1), 'password123');
        await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
        await tester.pumpAndSettle();

        expect(auth.isAuthenticated, isTrue);
        expect(find.byType(ProjectFormPage), findsOneWidget);
      },
    );

    testWidgets('ProjectFormPage validates optional Project Image URL', (
      WidgetTester tester,
    ) async {
      final mockClient = MockClient((request) async {
        if (request.url.path.endsWith('/auth/token/')) {
          return http.Response(jsonEncode({'token': 'valid-token'}), 200);
        }
        return http.Response('Not found', 404);
      });

      final auth = AuthProvider(client: mockClient);
      await auth.login('owner', 'password123');

      await tester.pumpWidget(
        ChangeNotifierProvider<AuthProvider>.value(
          value: auth,
          child: const MaterialApp(home: ProjectFormPage()),
        ),
      );
      await tester.pumpAndSettle();

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'Demo Project');
      await tester.enterText(fields.at(3), 'Demo Description');
      await tester.enterText(fields.at(4), 'not-a-valid-url');

      await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pumpAndSettle();

      expect(
        find.text('Masukkan URL yang valid (diawali http:// atau https://)!'),
        findsOneWidget,
      );
    });
  });
}
