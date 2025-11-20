import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/risk_badge.dart';
import '../../../core/constants/styles.dart';
import '../../../core/utils/formatter.dart';

class RiskMeterWidget extends StatelessWidget {
  final int riskPercent;
  final double size;

  const RiskMeterWidget({super.key, required this.riskPercent, this.size = 160});

  @override
  Widget build(BuildContext context) {
    final Color color = riskPercent < 40
        ? AppColors.success
        : riskPercent < 70
            ? AppColors.warning
            : AppColors.danger;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: (riskPercent.clamp(0, 100)) / 100,
                  strokeWidth: 14,
                  backgroundColor: Colors.grey.withOpacity(0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Formatter.percent(riskPercent),
                    style: AppStyles.title.copyWith(fontSize: 28),
                  ),
                  const SizedBox(height: 6),
                  RiskBadge(risk: riskPercent),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Risk Level",
          style: AppStyles.subtitle,
        ),
        const SizedBox(height: 4),
        Text(
          "Persentase risiko kecelakaan saat ini",
          style: AppStyles.body,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
