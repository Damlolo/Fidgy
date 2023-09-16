import 'dart:async';

import 'package:flutter/foundation.dart';

class GameClock extends ValueNotifier<String> {
  final Duration gameDuration;
  final Duration warningPoint;
  Duration remainingTime = const Duration();
  Timer? _timer;

  GameClock(
    this.gameDuration,
    this.warningPoint,
  ) : super('');

  bool get passedWarningPoint => remainingTime <= warningPoint;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void start() {
    final gameDurationInSeconds = gameDuration.inSeconds;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final timePassed = timer.tick;

        final remainingTimeInSeconds = gameDurationInSeconds - timePassed;
        remainingTime = Duration(seconds: remainingTimeInSeconds);
        _updateTimeValue();

        if (timePassed == gameDurationInSeconds) {
          timer.cancel();
        }
      },
    );
  }

  void stop() {
    _timer?.cancel();
  }

  void _updateTimeValue() {
    int secondsLeft = remainingTime.inSeconds;

    final hours = secondsLeft ~/ (60 * 60);
    secondsLeft = secondsLeft % (60 * 60);

    final minutes = secondsLeft ~/ 60;
    secondsLeft = secondsLeft % 60;

    String timeString = '';
    if (hours > 0) {
      timeString = '$hours:';
    }

    timeString = '$timeString${'$minutes'.padLeft(2, '0')}:';
    timeString = '$timeString${'$secondsLeft'.padLeft(2, '0')}';

    value = timeString;
  }
}
