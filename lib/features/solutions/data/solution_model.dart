class SolutionModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final int riskLevel;

  SolutionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.riskLevel,
  });

  factory SolutionModel.fromJson(Map<String, dynamic> json) {
    return SolutionModel(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      category: json['category'],
      riskLevel: int.tryParse(json['riskLevel'].toString()) ?? 0,
    );
  }
}
