import 'package:material_ui/material_ui.dart';

import '../models/experience.dart';
import '../services/api_client.dart';

class ExperienceDetailScreen extends StatelessWidget {
  const ExperienceDetailScreen({super.key, required this.experienceId});

  final String experienceId;

  bool _isHttpUrl(String value) {
    final uri = Uri.tryParse(value.trim());
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Project / Experience Detail')),
      body: FutureBuilder<Experience>(
        future: ApiClient.getExperienceDetail(experienceId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Gagal memuat detail: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final experience = snapshot.data!;
          final imageUrl = experience.image.trim();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imageUrl.isNotEmpty && _isHttpUrl(imageUrl))
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const SizedBox.shrink(),
                    ),
                  ),
                if (imageUrl.isNotEmpty && _isHttpUrl(imageUrl))
                  const SizedBox(height: 16),
                Text(
                  experience.title,
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                if (experience.institution.isNotEmpty)
                  Text(
                    'Institusi: ${experience.institution}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                if (experience.period.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Periode: ${experience.period}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
                const SizedBox(height: 8),
                Text('★ ${experience.starCount} stars'),
                const Divider(height: 24),
                Text(
                  'Deskripsi',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  experience.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                if (imageUrl.isNotEmpty && !_isHttpUrl(imageUrl)) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Image Asset: $imageUrl',
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
