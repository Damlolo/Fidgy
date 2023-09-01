import 'package:flutter/material.dart';

import '../../../presentation.dart';
import '../buttons_and_ctas/app_back_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final showBackButton = AppNavigator.of(context).canPop;
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: double.infinity),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showBackButton)
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: AppBackButton(),
            ),
          Text(
            title,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.of(context).heading24Bold,
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              softWrap: true,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.of(context).body16Regular.copyWith(
                    color: AppColors.of(context).textMedium,
                  ),
            ),
        ],
      ),
    );
  }
}
