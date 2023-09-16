import 'dart:async';

import 'package:flutter/material.dart';

import 'application.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(const ThisApplication());
    },
    (error, stack) {},
  );
}
