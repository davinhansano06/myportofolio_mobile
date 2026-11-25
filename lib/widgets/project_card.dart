
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import '../screens/education_list_screen.dart';
import '../screens/experience_list_screen.dart';
import '../providers/auth_provider.dart';
import '../screens/menu.dart';
import '../screens/project_form.dart';
import '../screens/education_form.dart';
import '../screens/login_screen.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [item.color, const Color(0xFF071A3D)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () async {
            if (item.name == 'Logout') {
              await context.read<AuthProvider>().logout();
              if (!context.mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
              return;
            }
            if (item.name == 'Lihat Proyek') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ExperienceListScreen(),
                ),
              );
              return;
            }

            if (item.name == 'Lihat Education') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EducationListScreen(),
                ),
              );
              return;
            }

            if (item.name == 'Tambah Proyek' ||
                item.name == 'Tambah Education') {
              if (!context.read<AuthProvider>().isAuthenticated) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
                return;
              }
            }

            if (item.name == 'Tambah Proyek') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProjectFormPage()),
              );
            } else if (item.name == 'Tambah Education') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EducationFormPage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Kamu menekan ${item.name}')),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30),
                const SizedBox(height: 6),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
