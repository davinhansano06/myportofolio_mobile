import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
        DrawerHeader(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                colors: [
                    Color(0xFF071A3D),
                    Color(0xFF2563A6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                ),
            ),
            child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                    'My Portfolio',
                    style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    ),
                ),
                SizedBox(height: 10),
                Text(
                    'Explore personal projects and experiences!',
                    style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    ),
                ),
                ],
            ),
            ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Navigasi ke halaman utama portofolio
            onTap: () {
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                ),
                );
            },
            ),
        ],
      ),
    );
  }
}