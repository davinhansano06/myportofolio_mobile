import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../screens/login_screen.dart';

Future<bool> ensureLoggedIn(BuildContext context) async {
  final auth = context.read<AuthProvider>();
  if (auth.isAuthenticated) {
    return true;
  }

  final loggedIn = await Navigator.push<bool>(
    context,
    MaterialPageRoute(builder: (_) => const LoginScreen()),
  );

  if (!context.mounted) return false;
  return loggedIn == true && context.read<AuthProvider>().isAuthenticated;
}

Future<bool> handleUnauthorized(BuildContext context) async {
  await context.read<AuthProvider>().logout();
  if (!context.mounted) return false;

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Sesi login telah berakhir. Silakan login kembali.'),
    ),
  );

  return ensureLoggedIn(context);
}
