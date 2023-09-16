import 'package:flutter/material.dart';

import '../../../common/presentation/presentation.dart';
import '../../../core/theming/app_colors.dart';
import '../../../core/theming/sizing_ext.dart';

class AppDialog extends StatelessWidget {
  final String heading;
  final Color? color;
  final VoidCallback? onClose;
  final WidgetBuilder builder;

  const AppDialog({
    super.key,
    required this.heading,
    required this.builder,
    this.onClose,
    this.color,
  });

  Future<void> open() {
    return AppNavigator.main.openDialog(dialog: this);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        children: [
          Container(
            constraints: const BoxConstraints(
              // maxHeight: 600,
              maxWidth: 800,
            ),
            padding: EdgeInsets.all(80.r),
            decoration: BoxDecoration(
              color: color ?? AppColors.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(80.r),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(5, 10),
                ),
              ],
            ),
            child: FittedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    heading,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 56.t),
                  ),
                  SizedBox(height: 48.r),
                  builder(context),
                ],
              ),
            ),
          ),
          Positioned(
            top: -32.r,
            right: -32.r,
            child: InkResponse(
              onTap: onClose ?? AppNavigator.of(context).pop,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.of(context).mainBlue,
                ),
                child: Icon(
                  Icons.close_rounded,
                  size: 120.r,
                  color: AppColors.of(context).textStrong,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
