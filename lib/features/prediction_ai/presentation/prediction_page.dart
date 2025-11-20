import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/risk_badge.dart';
import '../../../core/utils/formatter.dart';
import '../data/prediction_repository.dart';
import '../data/ai_prediction_model.dart';
import 'risk_factors_widget.dart';

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  late final PredictionRepository _repo;
  late Future<AiPredictionModel> _future;

  @override
  void initState() {
    super.initState();
    _repo = PredictionRepository();
    _future = _repo.fetchPrediction();
  }

  Future<void> _refresh() async {
    setState(() {
      _future = _repo.fetchPrediction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("AI Risk Prediction")),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<AiPredictionModel>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: 300,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return Text("Failed to load data", style: AppStyles.body);
              }

              final model = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCard(
                    child: Column(
                      children: [
                        Text("Prediksi Risiko Hari Ini", style: AppStyles.title),
                        const SizedBox(height: 10),
                        Text(Formatter.percent(model.riskPercent),
                            style: AppStyles.title.copyWith(fontSize: 32)),
                        const SizedBox(height: 6),
                        RiskBadge(risk: model.riskPercent),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text("Faktor Risiko Penyebab", style: AppStyles.title),
                  const SizedBox(height: 12),
                  RiskFactorsWidget(factors: model.factors),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
