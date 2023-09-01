import 'package:flutter/material.dart';

import '../../../presentation.dart';
import '../loaders/app_loading_indicator.dart';

enum _ButtonType {
  primary,
  secondary,
  text;

  bool get isPrimary => this == primary;
  bool get isSecondary => this == secondary;
}

class AppButton extends StatelessWidget {
  const AppButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
    this.busy = false,
    this.color,
    this.textColor = Colors.white,
    this.enabled = true,
  }) : _type = _ButtonType.primary;

  const AppButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.busy = false,
    this.color,
    Color? outlineColor,
    this.enabled = true,
  })  : _type = _ButtonType.secondary,
        textColor = outlineColor;

  const AppButton.text({
    super.key,
    required this.label,
    required this.onPressed,
    this.busy = false,
    this.textColor = Colors.white,
    this.enabled = true,
  })  : _type = _ButtonType.text,
        color = Colors.transparent;

  final String label;
  final bool busy;
  final bool enabled;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;

  final _ButtonType _type;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    Color textColor;
    if (!enabled) {
      textColor = colors.textMedium;
    } else if (_type.isPrimary) {
      textColor = colors.grey5;
    } else {
      textColor = colors.textStrong;
    }

    final textStyle = AppStyles.of(context).button16Bold.copyWith(
          color: textColor,
        );

    return TextButton(
      onPressed: enabled && !busy
          ? () {
              FocusScope.of(context).unfocus();
              onPressed();
            }
          : null,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size.fromHeight(56)),
        backgroundColor: MaterialStateColor.resolveWith((states) {
          if (!_type.isPrimary) return Colors.transparent;
          if (states.contains(MaterialState.disabled)) {
            return colors.grey5;
          }
          if (states.contains(MaterialState.pressed) ||
              states.contains(MaterialState.focused)) {
            return colors.attitudeSuccessMain;
          }
          if (states.contains(MaterialState.hovered)) {
            return colors.textMedium;
          }
          return color ?? colors.primaryColor;
        }),
        shape: MaterialStateProperty.resolveWith((states) {
          if (_type == _ButtonType.text) return null;

          Color? getBorderColor(Set<MaterialState> states) {
            if (!_type.isSecondary && states.contains(MaterialState.pressed)) {
              return colors.primaryColor;
            }
            if (!_type.isSecondary) return null;
            if (states.contains(MaterialState.disabled)) {
              return colors.grey5;
            }
            if (states.contains(MaterialState.pressed)) {
              return colors.attitudeSuccessMain;
            }
            return colors.primaryColor;
          }

          final color = getBorderColor(states);

          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: color != null
                ? BorderSide(
                    width: 2,
                    color: color,
                  )
                : BorderSide.none,
          );
        }),
      ),
      child: busy ? const AppLoadingIndicator() : Text(label, style: textStyle),
    );
  }
}
