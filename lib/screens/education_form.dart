
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _institution = "";
  String _program = "";
  String _startYear = "";
  String _graduationYear = "";
  String _status = "Currently Studying";

  String? _validateYear(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Tahun tidak boleh kosong!";
    }

    if (!RegExp(r'^\d{4}$').hasMatch(value.trim())) {
      return "Masukkan tahun dengan 4 digit!";
    }

    final year = int.parse(value.trim());

    if (year < 1900 || year > 2100) {
      return "Masukkan tahun yang valid!";
    }

    if (_startYear.trim().isNotEmpty &&
        RegExp(r'^\d{4}$').hasMatch(_startYear.trim()) &&
        year < int.parse(_startYear.trim())) {
      return "Tahun tidak boleh sebelum tahun mulai!";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Add Education Form'),
        ),
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
                    labelText: "Institution",
                    hintText: "Contoh: Universitas Brawijaya",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _institution = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Institution tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Degree / Program",
                    hintText: "Contoh: S1 Pendidikan Dokter",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _program = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Program tidak boleh kosong!";
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
                    labelText: "Start Year",
                    hintText: "Contoh: 2024",
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
                    labelText: "Education Status",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "Currently Studying",
                      child: Text("Currently Studying"),
                    ),
                    DropdownMenuItem(
                      value: "Graduated",
                      child: Text("Graduated"),
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
                    labelText: _status == "Graduated"
                        ? "Graduation Year"
                        : "Expected Graduation",
                    hintText: "Contoh: 2028",
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

              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Education successfully added!',
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Institution: $_institution'),
                                    Text('Program: $_program'),
                                    Text('Start Year: $_startYear'),
                                    Text('Status: $_status'),
                                    Text(
                                      '${_status == "Graduated" ? "Graduation Year" : "Expected Graduation"}: $_graduationYear',
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
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
