import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  final AppColors colors;
  final String headingFontFamily;
  final String bodyFontFamily;
  // final AppStyles styles;

  AppTheme({
    required this.colors,
    required this.headingFontFamily,
    required this.bodyFontFamily,
  }) ;

  ThemeData get themeData => ThemeData(
        extensions: [colors],
        textTheme: GoogleFonts.mochiyPopOneTextTheme(),
        primaryTextTheme: GoogleFonts.mochiyPopOneTextTheme(),
        scaffoldBackgroundColor: colors.backgroundColor,
        primaryColor: colors.primaryColor,
        /*   appBarTheme: AppBarTheme(backgroundColor: colors.primaryColor),
        splashColor: colors.tertiaryColor,
        textTheme: TextTheme(
          bodySmall: styles.body14Regular,
          titleSmall: styles.body14Medium,
        ),
        canvasColor: colors.backgroundColor,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: colors.attitudeErrorMain,
          selectionColor: colors.grey3,
          selectionHandleColor: colors.secondaryColor,
        ),
        colorScheme: ColorScheme(
          primary: colors.primaryColor,
          onPrimary: colors.backgroundColor,
          secondary: colors.secondaryColor,
          onSecondary: colors.backgroundColor,
          background: colors.backgroundColor,
          onBackground: colors.backgroundColor,
          surface: colors.backgroundColor,
          onSurface: colors.textStrong,
          error: colors.attitudeErrorDark,
          onError: colors.attitudeErrorDark,
          brightness: Brightness.dark,
        ),
        dialogBackgroundColor: colors.backgroundColor,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: colors.backgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32),
            ),
          ),
        ), */
      );
}
