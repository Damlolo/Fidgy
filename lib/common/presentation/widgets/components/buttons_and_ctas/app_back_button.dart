import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../presentation.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({this.color, super.key});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: runtimeType,
      transitionOnUserGestures: true,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: AppNavigator.of(context).maybePop,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.arrow_left,
                color: color ?? AppColors.of(context).tertiaryColor,
              ),
              const SizedBox(width: 4),
              Text(
                'Go Back',
                style: AppStyles.of(context).body14Bold.copyWith(
                      height: 1,
                      color: color ?? AppColors.of(context).tertiaryColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
