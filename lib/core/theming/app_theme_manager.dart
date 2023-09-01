import 'package:flutter/material.dart';

import '../../common/presentation/presentation.dart';
import '../../services/local_storage_service/local_storage_service.dart';

export 'app_colors.dart';
export 'app_styles.dart';
export 'app_theme.dart';
export 'sizing_ext.dart';

class AppThemeManager extends AppViewModel {
  static bool forceDefault = false;

  final AppTheme _lightTheme;
  final AppTheme? _darkTheme;
  final ThemeMode _defaultMode;
  final LocalStorageService _localStore;

  ThemeMode? _themeMode;

  AppThemeManager({
    required AppTheme lightTheme,
    required AppTheme? darkTheme,
    required LocalStorageService localStore,
    ThemeMode defaultMode = ThemeMode.system,
  })  : _lightTheme = lightTheme,
        _darkTheme = darkTheme,
        _localStore = localStore,
        _defaultMode = defaultMode;

  ThemeData? get lightTheme => _lightTheme.themeData;
  ThemeData? get darkTheme => _darkTheme?.themeData;

  ThemeMode get themeMode => _themeMode ?? _defaultMode;

  Future<void> initialise(BuildContext context) async {
    if (forceDefault) {
      _themeMode = _defaultMode;
    } else {
      final mode = await _getLastTheme();
      _themeMode = mode;
    }
    setState();
  }

  Future<ThemeMode> _getLastTheme() async {
    final name = await _localStore.fetchString(LocalStoreKeys.THEME_MODE);
    final mode = ThemeMode.values.firstWhere(
      (element) => element.name == name,
      orElse: () => _defaultMode,
    );
    return mode;
  }

  void changeMode(ThemeMode mode) {
    if (mode == _themeMode) return;
    if (mode == ThemeMode.dark && _darkTheme == null) return;
    _themeMode = mode;
    _localStore.saveString(LocalStoreKeys.THEME_MODE, themeMode.name);
    setState();
  }
}
