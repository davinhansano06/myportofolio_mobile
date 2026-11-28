import 'package:material_ui/material_ui.dart';

import '../models/education.dart';
import '../services/api_client.dart';

class EducationDetailScreen extends StatelessWidget {
  const EducationDetailScreen({super.key, required this.educationId});

  final String educationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Education Detail')),
      body: FutureBuilder<Education>(
        future: ApiClient.getEducationDetail(educationId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Gagal memuat detail Education: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final education = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  education.institution,
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  education.degree,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text('Periode: ${education.period}'),
                const SizedBox(height: 4),
                Text('Lokasi: ${education.location}'),
                const SizedBox(height: 4),
                Text(
                  'Status: ${education.isCurrent ? "Currently Studying" : "Graduated"}',
                ),
                const SizedBox(height: 8),
                Text('★ ${education.starCount} stars'),
                const Divider(height: 24),
                Text(
                  'Skills',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(education.skills),
                if (education.starredByNames.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Starred by: ${education.starredByNames}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
