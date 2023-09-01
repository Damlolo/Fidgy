

mixin CustomWillPopScopeMixin {
  static bool _secondBack = false;
  static const secondTapDurationSpace = Duration(seconds: 2);
  Future<bool> onSecondBackPop() async {
    if (!_secondBack) {
      // TODO(Majore): Open Toast
      // AppToast.info('Press back again to close ${EnvironmentConfig.appName}')
      //     .show();
      _secondBack = true;
      Future.delayed(secondTapDurationSpace, () => _secondBack = false);
      return false;
    } else {
      return true;
    }
  }

  Future<bool> delayAndPop() async {
    // TODO(Majore): Open Toast
    // AppToast.info('Closing ${EnvironmentConfig.appName}').show();
    return Future.delayed(secondTapDurationSpace, () => true);
  }
}
