import 'package:flutter/material.dart';

import '../../../presentation.dart';

class AppMiniButton extends StatelessWidget {
  const AppMiniButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.enabled = true,
    this.busy = false,
    this.color,
    this.textColor,
  });

  final String label;
  final bool busy;
  final bool enabled;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final styles = AppStyles.of(context);
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 24,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: color ?? colors.tertiaryColor,
        ),
        child: Text(
          label,
          style: styles.body16Bold.copyWith(
            color: textColor ?? AppColors.of(context).textStrong,
            height: 1,
          ),
        ),
      ),
    );
  }
}
