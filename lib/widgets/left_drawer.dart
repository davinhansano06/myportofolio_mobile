import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/providers/auth_provider.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/education_list_screen.dart';
import 'package:myportofolio_mobile/screens/experience_list_screen.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/utils/auth_guard.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF071A3D), Color(0xFF2563A6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My Portfolio',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  auth.isAuthenticated && auth.username != null
                      ? 'Signed in as ${auth.username}'
                      : 'Explore personal projects and experiences!',
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),

          // Home
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
            },
          ),

          // Projects / Experiences
          ListTile(
            leading: const Icon(Icons.folder_outlined),
            title: const Text('Projects / Experiences'),
            onTap: () {
              final navContext = Navigator.of(context).context;
              Navigator.pop(context);
              Navigator.push(
                navContext,
                MaterialPageRoute(builder: (_) => const ExperienceListScreen()),
              );
            },
          ),

          // Education
          ListTile(
            leading: const Icon(Icons.school_outlined),
            title: const Text('Education'),
            onTap: () {
              final navContext = Navigator.of(context).context;
              Navigator.pop(context);
              Navigator.push(
                navContext,
                MaterialPageRoute(builder: (_) => const EducationListScreen()),
              );
            },
          ),

          // Add Project (Protected)
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            onTap: () async {
              final navContext = Navigator.of(context).context;
              Navigator.pop(context);
              final loggedIn = await ensureLoggedIn(navContext);
              if (!loggedIn || !navContext.mounted) return;
              Navigator.push(
                navContext,
                MaterialPageRoute(builder: (_) => const ProjectFormPage()),
              );
            },
          ),

          // Add Education (Protected)
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Add Education'),
            onTap: () async {
              final navContext = Navigator.of(context).context;
              Navigator.pop(context);
              final loggedIn = await ensureLoggedIn(navContext);
              if (!loggedIn || !navContext.mounted) return;
              Navigator.push(
                navContext,
                MaterialPageRoute(builder: (_) => const EducationFormPage()),
              );
            },
          ),

          const Divider(),

          // Login / Logout
          ListTile(
            leading: Icon(auth.isAuthenticated ? Icons.logout : Icons.login),
            title: Text(auth.isAuthenticated ? 'Logout' : 'Login'),
            onTap: () async {
              final navContext = Navigator.of(context).context;
              Navigator.pop(context);
              if (auth.isAuthenticated) {
                await navContext.read<AuthProvider>().logout();
                if (!navContext.mounted) return;
                ScaffoldMessenger.of(navContext).showSnackBar(
                  const SnackBar(content: Text('Berhasil logout.')),
                );
              } else {
                Navigator.push(
                  navContext,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
