import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../../common/domain/models/user_model.dart';

class ErrorLogService {
  //? Supply the implementation to use for this service in the app here
  static final ErrorLogService instance = ErrorLogService._();

  ErrorLogService._();

  late bool _isLogging;

  @protected
  bool get isLogging => _isLogging;

  @mustCallSuper
  void initialise({required bool isDebug}) {
    _isLogging = !isDebug && kReleaseMode;

    // Connect framework errors
    FlutterError.onError = recordFlutterError;

    // Connect errors on main isolate
    if (!kIsWeb) {
      Isolate.current.addErrorListener(RawReceivePort(
        (List<dynamic> pair) async => recordError(pair.first, pair.last),
      ).sendPort);
    }

    // Connect severe log events
    Logger.root.onRecord.listen(
      (event) {
        debugPrint(event.message);
        if (event.level >= Level.SEVERE) {
          recordError(
            event.error,
            event.stackTrace,
            reason: event.message,
            information: [event.loggerName, event.time],
          );
        }
      },
    );
  }

  FutureOr<void> connectUser(UserModel user) async {}
  FutureOr<void> disconnectUser() async {}

  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
    Iterable<Object> information = const [],
    bool fatal = false,
  }) async {}

  Future<void> recordFlutterError(FlutterErrorDetails errorDetails) async {}
}
