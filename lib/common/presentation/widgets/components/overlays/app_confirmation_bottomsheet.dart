import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../presentation.dart';

import '../buttons_and_ctas/app_button_widget.dart';
import 'app_bottom_sheet.dart';

// May be converted to a Dialog rather than a sheet,
// depending on design decision
class AppConfirmationSheet extends AppBottomSheet<bool> {
  AppConfirmationSheet({
    super.key,
    required String heading,
    required String? body,
    VoidCallback? yesOnPressed,
    String? yesLabel,
    String? cancelLabel,
    Widget? illustration,
  }) : super(
          heading: null,
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 32),
          builder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 124,
                width: 124,
                child: illustration ??
                    Lottie.asset(AppResources.i.attentionAnimation),
              ),
              const SizedBox(height: 0),
              Text(
                heading,
                textAlign: TextAlign.center,
                style: AppStyles.of(context).heading24Regular,
              ),
              if (body != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    body,
                    style: AppStyles.of(context).body16Regular,
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: AppButton.secondary(
                      label: cancelLabel ?? 'Cancel',
                      onPressed: () => AppNavigator.of(context).pop(false),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppButton.primary(
                      label: yesLabel ?? 'Yes',
                      onPressed: yesOnPressed ??
                          () => AppNavigator.of(context).pop(true),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
}
