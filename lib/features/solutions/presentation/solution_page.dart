import 'package:flutter/material.dart';
import '../data/solution_model.dart';
import 'solution_card.dart';
import '../../../core/constants/styles.dart';

class SolutionPage extends StatelessWidget {
  final List<SolutionModel> solutions;

  const SolutionPage({super.key, required this.solutions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rekomendasi Solusi")),

      body: solutions.isEmpty
          ? Center(child: Text("Tidak ada solusi", style: AppStyles.body))
          : ListView.builder(
              itemCount: solutions.length,
              itemBuilder: (context, i) {
                return SolutionCard(data: solutions[i]);
              },
            ),
    );
  }
}
