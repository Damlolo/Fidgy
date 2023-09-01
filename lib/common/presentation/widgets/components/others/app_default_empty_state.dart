import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../presentation.dart';
import '../buttons_and_ctas/app_button_widget.dart';

class DefaultEmptyState extends StatelessWidget {
  const DefaultEmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    this.illustration,
    required this.button,
  });

  final Widget? illustration;
  final String title;
  final String subtitle;
  final AppButton? button;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          illustration ??
              Lottie.asset(
                AppResources.i.notFoundAnimation,
                height: 144,
              ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppStyles.of(context).heading16Bold,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: AppStyles.of(context).body14Medium,
            textAlign: TextAlign.center,
          ),
          if (button != null) button!,
        ],
      ),
    );
  }
}
