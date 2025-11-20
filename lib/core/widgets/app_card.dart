import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/styles.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin; // ⬅ TAMBAHKAN INI

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,    // ⬅ TAMBAHKAN INI
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin, // ⬅ AKTIFKAN INI
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
