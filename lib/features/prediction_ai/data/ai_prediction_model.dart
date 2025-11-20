class AiPredictionModel {
  final int riskPercent;
  final List<RiskFactor> factors;

  AiPredictionModel({required this.riskPercent, required this.factors});

  factory AiPredictionModel.fromJson(Map<String, dynamic> json) {
    final list = (json['factors'] as List<dynamic>? ?? [])
        .map((e) => RiskFactor.fromJson(e))
        .toList();

    return AiPredictionModel(
      riskPercent: (json['risk_percent'] as num?)?.toInt() ?? 0,
      factors: list,
    );
  }

  Map<String, dynamic> toJson() => {
        'risk_percent': riskPercent,
        'factors': factors.map((e) => e.toJson()).toList(),
      };
}

class RiskFactor {
  final String name;
  final double weight;
  final String description;

  RiskFactor({
    required this.name,
    required this.weight,
    required this.description,
  });

  factory RiskFactor.fromJson(Map<String, dynamic> json) {
    return RiskFactor(
      name: json['name']?.toString() ?? '',
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      description: json['description']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'weight': weight,
        'description': description,
      };
}
