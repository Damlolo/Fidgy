import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/presentation/presentation.dart';
import '../core/service_locator/service_locator.dart';
import '../services/app_lifecycle_service/app_lifecycle_service.dart';
import '../utilities/constants/constants.dart';
import '../utilities/mixins/device_orientation_mixin.dart';

class ThisApplication extends StatefulWidget {
  const ThisApplication({super.key});

  @override
  State<ThisApplication> createState() => _ThisApplicationState();
}

class _ThisApplicationState extends State<ThisApplication>
    with DeviceOrientationMixin {
  late final AppThemeManager _themeManager;

  @override
  void initState() {
    AppLifecycleService.instance.initialise();
    _themeManager = AppThemeManager(
      lightTheme: AppTheme(
        colors: AppColors.defaultColors,
        headingFontFamily: AppStyles.defaultHeadingFont,
        bodyFontFamily: AppStyles.defaultBodyFont,
      ),
      darkTheme: null,
      localStore: ServiceLocator.get(),
      defaultMode: ThemeMode.system,
    );
    _themeManager.initialise(context);
    lockToLandscapeOrientation();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ScreenUtil.init(context, designSize: const Size(1440, 960));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    AppLifecycleService.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppViewBuilder<AppThemeManager>(
      model: _themeManager,
      initState: (vm) => vm.initialise(context),
      builder: (themeManager, _) => MaterialApp(
        theme: themeManager.lightTheme,
        darkTheme: themeManager.darkTheme,
        themeMode: themeManager.themeMode,
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
