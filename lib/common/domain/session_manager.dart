import 'package:flutter/material.dart';

import '../../core/service_locator/service_locator.dart';
import '../../services/error_logging_service/error_logging_service.dart';
import '../../services/local_storage_service/local_storage_service.dart';
import 'models/user_model.dart';

class SessionManager extends ChangeNotifier {
  final LocalStorageService localStorageService;
  final ErrorLogService errorLogService;

  late String _token;
  late UserModel _currentUser;

  bool _sessionIsOpen = false;

  final Map _sessionHeaders = <String, String>{};

  SessionManager({
    required this.localStorageService,
    required this.errorLogService,
  });

  bool get isOpen => _sessionIsOpen;
  String? get accessToken => _sessionIsOpen ? _token : null;
  UserModel get currentUser => _currentUser;

  Map<String, String> sessionHeaders(bool withToken) {
    final Map<String, String> headers = Map.from(_sessionHeaders);
    if (!withToken) {
      return headers;
    } else {
      return headers
        ..putIfAbsent(
          'Authorization',
          () => 'Bearer $accessToken',
        );
    }
  }

  void open({
    required AuthToken tokenData,
    required UserModel? user,
  }) {
    _token = tokenData.accessToken;
    _sessionIsOpen = true;
    if (user != null) {
      _currentUser = user;
      errorLogService.connectUser(user);
    }
    notifyListeners();
  }

  Future<void> close() async {
    if (_sessionIsOpen) {
      localStorageService.clearEntireStorage();
      errorLogService.disconnectUser();
      clearSessionHeaders();
      ServiceLocator.resetInstance<SessionManager>();
    }
  }

  bool updateUser(UserModel user) {
    if (_sessionIsOpen) {
      _currentUser = user;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void setSessionHeaders(Map<String, String> x) {
    _sessionHeaders.addAll(x);
  }

  void clearSessionHeaders() {
    _sessionHeaders.clear();
  }
}

class AuthToken {
  final String accessToken;
  final String refreshToken;
  final int expirationMilliseconds;

  AuthToken(
    this.accessToken,
    this.refreshToken,
    this.expirationMilliseconds,
  );

  DateTime get tokenExpiration =>
      DateTime.fromMillisecondsSinceEpoch(expirationMilliseconds);

  factory AuthToken.fromMap(Map<String, dynamic> map) {
    return AuthToken(
      map['access_token'] ?? '',
      map['refresh_token'] ?? '',
      (map['refresh_token_expiry'] ?? 1) * 1000,
    );
  }
}
