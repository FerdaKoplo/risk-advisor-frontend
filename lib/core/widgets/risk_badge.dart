import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/helpers.dart';

class RiskBadge extends StatelessWidget {
  final int risk;

  const RiskBadge({super.key, required this.risk});

  @override
  Widget build(BuildContext context) {
    Color color = risk < 40
        ? AppColors.success
        : risk < 70
            ? AppColors.warning
            : AppColors.danger;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        RiskHelper.getCategory(risk),
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
