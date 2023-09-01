import 'dart:async';

import '../../common/domain/app_responses.dart';

abstract class LocalAuthenticationService {
  bool get isAvailable;

  LocalAuthMethod get availableAuthMethod;

  Future<void> init();

  Future<DataResponse<bool>> authenticate();
}

enum LocalAuthMethod {
  faceId('Face Id'),
  fingerprint('Fingerprint'),
  pin('Fingerprint'),
  unavailable('');

  final String description;
  const LocalAuthMethod(this.description);
}
