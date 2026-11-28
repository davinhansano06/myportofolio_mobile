import 'package:material_ui/material_ui.dart';

import '../models/education.dart';
import '../services/api_client.dart';
import '../utils/auth_guard.dart';
import 'education_detail_screen.dart';
import 'education_form.dart';

class EducationListScreen extends StatefulWidget {
  const EducationListScreen({super.key});

  @override
  State<EducationListScreen> createState() => _EducationListScreenState();
}

class _EducationListScreenState extends State<EducationListScreen> {
  late Future<List<Education>> _educationsFuture;

  @override
  void initState() {
    super.initState();
    _educationsFuture = ApiClient.getEducations();
  }

  Future<void> _refresh() async {
    setState(() {
      _educationsFuture = ApiClient.getEducations();
    });
    await _educationsFuture;
  }

  Future<void> _openAddForm() async {
    final loggedIn = await ensureLoggedIn(context);
    if (!loggedIn || !mounted) return;

    final created = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const EducationFormPage()),
    );

    if (created == true && mounted) {
      await _refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Education')),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddForm,
        tooltip: 'Tambah Education',
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Education>>(
        future: _educationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Gagal memuat Education: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _refresh,
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final educations = snapshot.data ?? [];

          if (educations.isEmpty) {
            return const Center(child: Text('Belum ada data Education.'));
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              EducationDetailScreen(educationId: education.id),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
