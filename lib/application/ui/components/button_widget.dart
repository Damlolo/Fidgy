import 'package:flutter/material.dart';

import '../../../core/theming/app_colors.dart';
import '../../../core/theming/sizing_ext.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onTap,
    required this.label,
    this.color,
  });

  final Color? color;
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      radius: 40,
      borderRadius: BorderRadius.circular(32.r),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 180.r,
          minHeight: 70.r,
          minWidth: 250.r,
          maxWidth: 800.r,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.r),
            color: color ?? AppColors.of(context).mainBlue,
            border: Border.all(
              color: AppColors.of(context).textStrong,
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(5, 10),
              ),
            ],
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 68.t,
                  color: AppColors.of(context).textStrong,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
