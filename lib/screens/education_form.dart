import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/models/education.dart';
import 'package:myportofolio_mobile/providers/auth_provider.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/utils/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _institution = '';
  String _program = '';
  String _startYear = '';
  String _graduationYear = '';
  String _status = 'Currently Studying';
  String _location = '';
  String _skills = '';
  String _logo = 'img/uiputih.png';
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      final loggedIn = await ensureLoggedIn(context);
      if (!loggedIn && mounted && Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });
  }

  String? _validateYear(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Tahun tidak boleh kosong!';
    }

    if (!RegExp(r'^\d{4}$').hasMatch(value.trim())) {
      return 'Masukkan tahun dengan 4 digit!';
    }

    final year = int.parse(value.trim());

    if (year < 1900 || year > 2100) {
      return 'Masukkan tahun yang valid!';
    }

    if (_startYear.trim().isNotEmpty &&
        RegExp(r'^\d{4}$').hasMatch(_startYear.trim()) &&
        year < int.parse(_startYear.trim())) {
      return 'Tahun tidak boleh sebelum tahun mulai!';
    }

    return null;
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final loggedIn = await ensureLoggedIn(context);
    if (!loggedIn || !mounted) return;

    final token = context.read<AuthProvider>().token;
    if (token == null || token.isEmpty) return;

    setState(() {
      _submitting = true;
    });

    try {
      final created = await ApiClient.createEducation(
        Education(
          institution: _institution.trim(),
          degree: _program.trim(),
          period: '${_startYear.trim()} - ${_graduationYear.trim()}',
          location: _location.trim(),
          skills: _skills.trim(),
          isCurrent: _status == 'Currently Studying',
          logo: _logo.trim(),
        ),
        token,
      );

      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Education successfully added!'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Institution: ${created.institution}'),
                  Text('Program: ${created.degree}'),
                  Text('Period: ${created.period}'),
                  Text('Location: ${created.location}'),
                  Text('Skills: ${created.skills}'),
                  Text(
                    'Status: ${created.isCurrent ? "Currently Studying" : "Graduated"}',
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      if (!mounted) return;
      _formKey.currentState?.reset();
      Navigator.pop(context, true);
    } on UnauthorizedException {
      if (!mounted) return;
      await handleUnauthorized(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyimpan Education: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _submitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Education Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Institution',
                    hintText: 'Contoh: Universitas Indonesia',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _institution = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Institution tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Degree / Program',
                    hintText: 'Contoh: S1 Sistem Informasi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _program = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Program tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Start Year',
                    hintText: 'Contoh: 2024',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    _startYear = value;
                  },
                  validator: _validateYear,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  initialValue: _status,
                  decoration: InputDecoration(
                    labelText: 'Education Status',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Currently Studying',
                      child: Text('Currently Studying'),
                    ),
                    DropdownMenuItem(
                      value: 'Graduated',
                      child: Text('Graduated'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: _status == 'Graduated'
                        ? 'Graduation Year'
                        : 'Expected Graduation',
                    hintText: 'Contoh: 2028',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    _graduationYear = value;
                  },
                  validator: _validateYear,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Location',
                    hintText: 'Contoh: Depok, West Java, Indonesia',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _location = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Location tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Skills',
                    hintText: 'Contoh: Flutter, Django, Data Analysis',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _skills = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Skills tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _logo,
                  decoration: InputDecoration(
                    labelText: 'Logo Path / URL',
                    hintText: 'Contoh: img/uiputih.png',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _logo = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Logo tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: _submitting ? null : _submitForm,
                    child: Text(
                      _submitting ? 'Saving...' : 'Save',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
