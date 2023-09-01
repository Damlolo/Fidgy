import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles extends ThemeExtension<AppStyles> {
  final AppColors colors;
  final String headingFontFamily;
  final String bodyFontFamily;

  static const defaultHeadingFont = 'Outfit';
  static const defaultBodyFont = 'DarkerGrotesque';

  static AppStyles of(BuildContext context) {
    final theme = Theme.of(context).extension<AppStyles>();
    if (theme == null) {
      throw Exception('AppStyles has not been added to app theme extensions');
    }
    return theme;
  }

  final TextStyle heading64Bold;
  final TextStyle heading40Regular;
  final TextStyle heading40Bold;
  final TextStyle heading32Regular;
  final TextStyle heading32Bold;
  final TextStyle heading24Regular;
  final TextStyle heading24Bold;
  final TextStyle heading16Regular;
  final TextStyle heading16Bold;
  final TextStyle body16Regular;
  final TextStyle body16Medium;
  final TextStyle body16SemiBold;
  final TextStyle body16Bold;
  final TextStyle body14Regular;
  final TextStyle body14Medium;
  final TextStyle body14SemiBold;
  final TextStyle body14Bold;
  final TextStyle body12Regular;
  final TextStyle body12SemiBold;
  final TextStyle body10Regular;
  final TextStyle body10SemiBold;
  final TextStyle button16Regular;
  final TextStyle button16Bold;
  final TextStyle button14Regular;
  final TextStyle button14Bold;
  final TextStyle button12Regular;
  final TextStyle button12Bold;
  final TextStyle value16Medium;
  final TextStyle label14Regular;
  final TextStyle hint12Medium;

  AppStyles({
    required this.colors,
    required this.headingFontFamily,
    required this.bodyFontFamily,
  })  : heading64Bold = TextStyle(
          fontFamily: headingFontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 64,
          height: 72 / 64,
          color: colors.textStrong,
        ),
        heading40Bold = TextStyle(
          fontFamily: headingFontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 40,
          height: 48 / 40,
          color: colors.textStrong,
        ),
        heading40Regular = TextStyle(
          fontFamily: headingFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 40,
          height: 48 / 40,
          color: colors.textStrong,
        ),
        heading32Bold = TextStyle(
          fontFamily: headingFontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 32,
          height: 40 / 32,
          color: colors.textStrong,
        ),
        heading32Regular = TextStyle(
          fontFamily: headingFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 32,
          height: 40 / 32,
          color: colors.textStrong,
        ),
        heading24Bold = TextStyle(
          fontFamily: headingFontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 24,
          height: 32 / 24,
          color: colors.textStrong,
        ),
        heading24Regular = TextStyle(
          fontFamily: headingFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 24,
          height: 32 / 24,
          color: colors.textStrong,
        ),
        heading16Bold = TextStyle(
          fontFamily: headingFontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 16,
          height: 24 / 16,
          color: colors.textStrong,
        ),
        heading16Regular = TextStyle(
          fontFamily: headingFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 24 / 16,
          color: colors.textStrong,
        ),
        button16Bold = TextStyle(
          fontFamily: headingFontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 16,
          height: 24 / 16,
          color: colors.textStrong,
        ),
        button16Regular = TextStyle(
          fontFamily: headingFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 24 / 16,
          color: colors.textStrong,
        ),
        button14Bold = TextStyle(
          fontFamily: headingFontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 14,
          height: 20 / 14,
          color: colors.textStrong,
        ),
        button14Regular = TextStyle(
          fontFamily: headingFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 20 / 14,
          color: colors.textStrong,
        ),
        button12Bold = TextStyle(
          fontFamily: headingFontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 12,
          height: 16 / 12,
          color: colors.textStrong,
        ),
        button12Regular = TextStyle(
          fontFamily: headingFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 12,
          height: 16 / 12,
          color: colors.textStrong,
        ),
        body16Regular = TextStyle(
          fontFamily: bodyFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 24 / 16,
          color: colors.textStrong,
        ),
        body16Medium = TextStyle(
          fontFamily: bodyFontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          height: 24 / 16,
          color: colors.textStrong,
        ),
        body16SemiBold = TextStyle(
          fontFamily: bodyFontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          height: 24 / 16,
          color: colors.textStrong,
        ),
        body16Bold = TextStyle(
          fontFamily: bodyFontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 16,
          height: 24 / 16,
          color: colors.textStrong,
        ),
        body14Regular = TextStyle(
          fontFamily: bodyFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 20 / 14,
          color: colors.textStrong,
        ),
        body14Medium = TextStyle(
          fontFamily: bodyFontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 20 / 14,
          color: colors.textStrong,
        ),
        body14SemiBold = TextStyle(
          fontFamily: bodyFontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          height: 20 / 14,
          color: colors.textStrong,
        ),
        body14Bold = TextStyle(
          fontFamily: bodyFontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 14,
          height: 20 / 14,
          color: colors.textStrong,
        ),
        body12Regular = TextStyle(
          fontFamily: bodyFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 12,
          height: 16 / 12,
          color: colors.textStrong,
        ),
        body12SemiBold = TextStyle(
          fontFamily: bodyFontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 12,
          height: 16 / 12,
          color: colors.textStrong,
        ),
        body10Regular = TextStyle(
          fontFamily: bodyFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 10,
          height: 14 / 10,
          color: colors.textStrong,
        ),
        body10SemiBold = TextStyle(
          fontFamily: bodyFontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 10,
          height: 14 / 10,
          color: colors.textStrong,
        ),
        value16Medium = TextStyle(
          fontFamily: bodyFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 24 / 16,
          color: colors.textStrong,
        ),
        label14Regular = TextStyle(
          fontFamily: bodyFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 20 / 14,
          color: colors.textStrong,
        ),
        hint12Medium = TextStyle(
          fontFamily: bodyFontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 12,
          height: 16 / 12,
          color: colors.textStrong,
        );

  @override
  ThemeExtension<AppStyles> copyWith(
      {AppColors? colors, String? headingFontFamily, String? bodyFontFamily}) {
    return AppStyles(
      colors: colors ?? this.colors,
      headingFontFamily: headingFontFamily ?? this.headingFontFamily,
      bodyFontFamily: bodyFontFamily ?? this.bodyFontFamily,
    );
  }

  @override
  ThemeExtension<AppStyles> lerp(
      covariant ThemeExtension<AppStyles>? other, double t) {
    return other ?? this;
  }
}
