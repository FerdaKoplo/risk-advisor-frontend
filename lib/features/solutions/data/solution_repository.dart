import '../../../core/services/api_service.dart';
import 'solution_model.dart';
import 'risk_request_model.dart';

class SolutionRepository {
  final ApiService api;

  SolutionRepository(this.api);

  // Kirim input user → backend → dapat solusi
  Future<List<SolutionModel>> submitRisk(RiskRequestModel req) async {
    final res = await api.post('/solutions/recommend', req.toJson());

    final data = res.data; // BODY JSON

    return (data['solutions'] as List)
        .map((item) => SolutionModel.fromJson(item))
        .toList();
  }
}

