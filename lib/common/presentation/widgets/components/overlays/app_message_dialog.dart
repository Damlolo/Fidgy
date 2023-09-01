import 'package:flutter/material.dart';

import '../../../presentation.dart';
import '../buttons_and_ctas/app_button_widget.dart';

class AppMessageDialog<T> extends StatelessWidget {
  const AppMessageDialog({
    super.key,
    required this.icon,
    required this.heading,
    required this.body,
    required this.buttons,
  });

  final String icon;
  final String heading;
  final Widget body;
  final List<AppButton> buttons;

  Future<T?> show({
    BuildContext? context,
    String? routeName,
  }) async {
    final navigator =
        context == null ? AppNavigator.main : AppNavigator.of(context);
    final value = await navigator.openDialog(
      dialog: this,
      routeName: routeName,
    );
    return value;
  }

  @override
  Widget build(BuildContext context) {
    final styles = AppStyles.of(context);
    final colors = AppColors.of(context);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: colors.tertiaryColor,
              child: Text(
                icon,
                style: styles.heading32Bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                heading,
                style: styles.heading24Bold,
              ),
            ),
            body,
            for (final button in buttons)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: button,
              ),
          ],
        ),
      ),
    );
  }
}
