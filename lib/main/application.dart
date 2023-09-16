import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/presentation/presentation.dart';
import '../core/theming/app_colors.dart';
import '../core/theming/app_theme.dart';
import '../utilities/constants/constants.dart';
import '../utilities/mixins/device_orientation_mixin.dart';

class ThisApplication extends StatefulWidget {
  const ThisApplication({super.key});

  @override
  State<ThisApplication> createState() => _ThisApplicationState();
}

class _ThisApplicationState extends State<ThisApplication>
    with DeviceOrientationMixin {
  @override
  void initState() {
    lockToLandscapeOrientation();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 960),
      minTextAdapt: true,
      child: MaterialApp(
        theme: AppTheme(
          colors: AppColors.defaultColors,
          bodyFontFamily: '',
          headingFontFamily: '',
        ).themeData,
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
        ],
        initialRoute: '/',
        navigatorKey: AppNavigator.mainKey,
        routes: AppRoutes.routes,
        onGenerateRoute: AppRoutes.generateRoutes,
        navigatorObservers: [AppNavigatorObserver.instance],
      ),
    );
  }
}
