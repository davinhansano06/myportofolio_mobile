import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/providers/auth_provider.dart';
import 'package:myportofolio_mobile/screens/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.authProvider});

  final AuthProvider? authProvider;

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'MyPortfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          secondary: Colors.amber[700],
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );

    if (authProvider != null) {
      return ChangeNotifierProvider<AuthProvider>.value(
        value: authProvider!,
        child: app,
      );
    }

    return ChangeNotifierProvider<AuthProvider>(
      create: (_) => AuthProvider(),
      child: app,
    );
  }
}
