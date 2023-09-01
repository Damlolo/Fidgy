import 'package:local_auth/local_auth.dart';
import 'package:logging/logging.dart';

import '../../common/data/app_repository.dart';
import 'local_authentication_service.dart';

class LocalAuthImplService extends LocalAuthenticationService {
  final LocalAuthentication _auth;
  final String appName;

  LocalAuthImplService(
    this._auth,
    this.appName,
  );

  late bool _authIsAvailable;
  LocalAuthMethod _method = LocalAuthMethod.unavailable;

  @override
  bool get isAvailable => _authIsAvailable;

  @override
  LocalAuthMethod get availableAuthMethod => _method;

  @override
  Future<void> init() async {
    try {
      final available = await Future.wait([
        _auth.canCheckBiometrics,
        _auth.isDeviceSupported(),
      ]);
      _authIsAvailable = available.any((check) => check == true);

      if (_authIsAvailable) {
        final methods = await _auth.getAvailableBiometrics();
        if (methods.isEmpty) {
          _method = LocalAuthMethod.unavailable;
        } else if (methods.contains(BiometricType.face) ||
            methods.contains(BiometricType.iris)) {
          _method = LocalAuthMethod.faceId;
        } else if (methods.contains(BiometricType.fingerprint)) {
          _method = LocalAuthMethod.fingerprint;
        } else {
          _method = LocalAuthMethod.pin;
        }
      }
    } catch (e, t) {
      Logger(runtimeType.toString()).severe('Init $runtimeType failed', e, t);
      throw (ServerException(
        errorMessage: 'Could not initialise biometrics',
      ));
    }
  }

  @override
  Future<DataResponse<bool>> authenticate() async {
    try {
      final authenticate = await _auth.authenticate(
        localizedReason: 'Sign in to your $appName account',
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: false,
          stickyAuth: true,
        ),
      );

      if (authenticate) {
        return DataResponse(data: true);
      } else {
        return DataResponse(
          data: false,
          error: InputFailure(message: 'Biometric Login failed'),
        );
      }
    } catch (e, t) {
      Logger(runtimeType.toString())
          .severe('Authenticate with Biometric failed', e, t);
      throw (ServerException(
        errorMessage: 'Could not authenticate with biometrics',
      ));
    }
  }
}
