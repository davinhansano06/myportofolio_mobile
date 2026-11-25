
import 'package:material_ui/material_ui.dart';

import '../models/education.dart';
import '../services/api_client.dart';

class EducationListScreen extends StatelessWidget {
  const EducationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Education')),
      body: FutureBuilder<List<Education>>(
        future: ApiClient.getEducations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Gagal memuat Education: ${snapshot.error}'),
            );
          }

          final educations = snapshot.data ?? [];

          if (educations.isEmpty) {
            return const Center(child: Text('Belum ada data Education.'));
          }

          return ListView.builder(
            itemCount: educations.length,
            itemBuilder: (context, index) {
              final education = educations[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.school),
                  title: Text(education.institution),
                  subtitle: Text(
                    '${education.degree}\n'
                    '${education.period} • ${education.location}',
                  ),
                  isThreeLine: true,
                  trailing: Text('★ ${education.starCount}'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(education.institution),
                        content: Text(
                          'Degree: ${education.degree}\n'
                          'Period: ${education.period}\n'
                          'Location: ${education.location}\n'
                          'Skills: ${education.skills}\n'
                          'Current: ${education.isCurrent}',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
