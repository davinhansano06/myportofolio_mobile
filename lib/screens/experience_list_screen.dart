
import 'package:material_ui/material_ui.dart';

import '../models/experience.dart';
import '../services/api_client.dart';

class ExperienceListScreen extends StatelessWidget {
  const ExperienceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projects / Experiences')),
      body: FutureBuilder<List<Experience>>(
        future: ApiClient.getExperiences(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Gagal memuat data: ${snapshot.error}'),
            );
          }

          final experiences = snapshot.data ?? [];

          if (experiences.isEmpty) {
            return const Center(child: Text('Belum ada data.'));
          }

          return ListView.builder(
            itemCount: experiences.length,
            itemBuilder: (context, index) {
              final experience = experiences[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.folder),
                  title: Text(experience.title),
                  subtitle: Text(
                    '${experience.institution}\n'
                    '${experience.period}\n'
                    '${experience.description}',
                  ),
                  isThreeLine: true,
                  trailing: Text('★ ${experience.starCount}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
