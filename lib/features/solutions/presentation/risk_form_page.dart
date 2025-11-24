import 'package:flutter/material.dart';
import '../data/risk_request_model.dart';
import '../data/solution_repository.dart';
import '../../../core/services/api_service.dart';
import 'solution_page.dart';

class RiskFormPage extends StatefulWidget {
  const RiskFormPage({super.key});

  @override
  State<RiskFormPage> createState() => _RiskFormPageState();
}

class _RiskFormPageState extends State<RiskFormPage> {
  final employeeCtrl = TextEditingController();
  final locationCtrl = TextEditingController();

  String? probInput;
  String? sevInput;
  String? compInput;

  late SolutionRepository repo;

  @override
  void initState() {
    super.initState();
    repo = SolutionRepository(ApiService());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Input Data Risiko")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: employeeCtrl,
              decoration: const InputDecoration(labelText: "Employee ID"),
            ),

            TextField(
              controller: locationCtrl,
              decoration: const InputDecoration(labelText: "Lokasi Area"),
            ),

            const SizedBox(height: 16),
            const Text("Probability"),
            DropdownButton<String>(
              value: probInput,
              isExpanded: true,
              items: ["Low", "Medium", "High"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => probInput = value),
            ),

            const SizedBox(height: 16),
            const Text("Severity"),
            DropdownButton<String>(
              value: sevInput,
              isExpanded: true,
              items: ["Low", "Medium", "High"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => sevInput = value),
            ),

            const SizedBox(height: 16),
            const Text("Competency"),
            DropdownButton<String>(
              value: compInput,
              isExpanded: true,
              items: ["Beginner", "Intermediate", "Expert"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => compInput = value),
            ),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                if (probInput == null || sevInput == null || compInput == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Form belum lengkap!")),
                  );
                  return;
                }

                final req = RiskRequestModel(
                  employeeId: employeeCtrl.text,
                  locationArea: locationCtrl.text,
                  probInput: probInput!,
                  sevInput: sevInput!,
                  compInput: compInput!,
                );

                final solutions = await repo.submitRisk(req);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SolutionPage(solutions: solutions),
                  ),
                );
              },
              child: const Text("Lihat Rekomendasi Solusi"),
            ),
          ],
        ),
      ),
    );
  }
}
