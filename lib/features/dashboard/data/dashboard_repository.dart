import 'package:dio/dio.dart';
import '../../../core/services/api_service.dart';
import 'dashboard_model.dart';

class DashboardRepository {
  final ApiService _api;

  DashboardRepository({ApiService? api}) : _api = api ?? ApiService();

  /// Fetch dashboard data from backend.
  /// Expected endpoint returns something like:
  /// {
  ///   "risk_percent": 62,
  ///   "daily_trend": [{"label":"2025-11-15","value":55}, ...]
  /// }
  Future<DashboardModel> fetchDashboard() async {
  try {
    final Response resp = await _api.get('/api/risk/dashboard');

    if (resp.statusCode == 200 && resp.data != null) {
      final Map<String, dynamic> data =
          Map<String, dynamic>.from(resp.data ?? {});
      return DashboardModel.fromJson(data);
    } else {
      return _mock();
    }
  } catch (e) {
    return _mock();
  }
}


  DashboardModel _mock() {
    // Example fallback data for frontend development
    final trend = List.generate(7, (i) => TrendPoint(label: 'D${i+1}', value: 40 + i * 4));
    return DashboardModel(riskPercent: 58, dailyTrend: trend);
  }
}
