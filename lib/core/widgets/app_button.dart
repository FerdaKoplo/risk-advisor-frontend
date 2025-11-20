import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const AppButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        minimumSize: const Size(double.infinity, 48),
      ),
      onPressed: onTap,
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
