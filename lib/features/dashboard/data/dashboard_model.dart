class DashboardModel {
  final int riskPercent;
  final List<TrendPoint> dailyTrend; // last N days

  DashboardModel({required this.riskPercent, required this.dailyTrend});

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    final trend = (json['daily_trend'] as List<dynamic>?)
            ?.map((e) => TrendPoint.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    return DashboardModel(
      riskPercent: (json['risk_percent'] as num?)?.toInt() ?? 0,
      dailyTrend: trend,
    );
  }

  Map<String, dynamic> toJson() => {
        'risk_percent': riskPercent,
        'daily_trend': dailyTrend.map((e) => e.toJson()).toList(),
      };
}

class TrendPoint {
  final String label; // e.g. date or "Mon"
  final num value;

  TrendPoint({required this.label, required this.value});

  factory TrendPoint.fromJson(Map<String, dynamic> json) {
    return TrendPoint(
      label: json['label']?.toString() ?? '',
      value: json['value'] as num? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {'label': label, 'value': value};
}
