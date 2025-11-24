class RiskRequestModel {
  final String employeeId;
  final String locationArea;
  final String probInput;
  final String sevInput;
  final String compInput;

  RiskRequestModel({
    required this.employeeId,
    required this.locationArea,
    required this.probInput,
    required this.sevInput,
    required this.compInput,
  });

  Map<String, dynamic> toJson() => {
    "employee_id": employeeId,
    "location_area": locationArea,
    "prob_input": probInput,
    "sev_input": sevInput,
    "comp_input": compInput,
  };
}
