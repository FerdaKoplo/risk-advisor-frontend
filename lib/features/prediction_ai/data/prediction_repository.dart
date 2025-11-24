import 'package:dio/dio.dart';
import '../../../core/services/api_service.dart';
import 'ai_prediction_model.dart';

class PredictionRepository {
  final ApiService _api;

  PredictionRepository({ApiService? api}) : _api = api ?? ApiService();

  Future<AiPredictionModel> fetchPrediction() async {
    try {
      final resp = await _api.post("/api/ai/safety-advice", {
        "employee_id": "E123",
        "location_area": "Warehouse 1",
        "prob_input": "medium",
        "sev_input": "high",
        "comp_input": "low"
      });

      if (resp.statusCode == 200 && resp.data != null) {
        final data = Map<String, dynamic>.from(resp.data);
        return AiPredictionModel.fromJson(data);
      } else {
        return _mock();
      }
    } catch (e) {
      return _mock();
    }
  }

  AiPredictionModel _mock() {
    return AiPredictionModel(
      riskPercent: 72,
      factors: [
        RiskFactor(
          name: "Cuaca Buruk",
          weight: 0.32,
          description: "Intensitas hujan tinggi meningkatkan risiko kecelakaan",
        ),
        RiskFactor(
          name: "Kepadatan Jalan",
          weight: 0.25,
          description: "Lalu lintas padat memperbesar potensi tabrakan",
        ),
        RiskFactor(
          name: "Jam Sibuk",
          weight: 0.18,
          description: "Pukul 06.00-08.00 adalah jam dengan insiden tertinggi",
        ),
      ],
    );
  }
}
