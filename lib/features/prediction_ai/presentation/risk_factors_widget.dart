import 'package:flutter/material.dart';
import '../../../core/constants/styles.dart';
import '../../../core/constants/colors.dart';
import '../data/ai_prediction_model.dart';
import '../../../core/widgets/app_card.dart';

class RiskFactorsWidget extends StatelessWidget {
  final List<RiskFactor> factors;

  const RiskFactorsWidget({super.key, required this.factors});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: factors.map((factor) {
        return AppCard(
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primary.withOpacity(0.15),
                child: Text(
                  (factor.weight * 100).toStringAsFixed(0) + '%',
                  style: AppStyles.subtitle.copyWith(fontSize: 11),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(factor.name, style: AppStyles.title),
                    const SizedBox(height: 4),
                    Text(factor.description, style: AppStyles.body),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
