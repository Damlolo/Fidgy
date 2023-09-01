import 'package:flutter/material.dart';

import '../../../presentation.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    super.key,
    this.color,
    this.bgColor = Colors.white,
  });
  final Color? color;
  final Color bgColor;
  @override
  Widget build(BuildContext context) {
    final color = this.color ?? AppColors.of(context).primaryColor;
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(color),
      color: bgColor,
      strokeWidth: 2,
    );
  }
}
