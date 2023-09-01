import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../common/presentation/presentation.dart';
import '../../common/presentation/widgets/components/overlays/app_toast_widget.dart';
import '../../core/service_locator/service_locator.dart';
import '../../services/local_storage_service/local_storage_service.dart';
import 'game_config.dart';
import 'general_manager.dart';

class Game extends AppViewModel {
  final GameConfig config;
  final TurnTimer timer;
  final Random _random;

  Game(this.config)
      : timer = TurnTimer(config.secondsPerTurn),
        _random = Random(config.randomnessSeed),
        _currentTurn = 0,
        _remainingLives = config.maxFailureAllowed;

  int _currentTurn;
  Finger? _currentFinger;
  int _remainingLives;

  int get remainingLives => _remainingLives;
  int get progress => _currentTurn;
  Finger? get fingerToTap => _currentFinger;

  void startPlaying() {
    _currentTurn = -1;
    _correctFingerTouched();
    timer.addListener(_timerListener);
  }

  void _timerListener() async {
    if (timer.value == 0) {
      _wrongSpaceTouched();
      if (remainingLives > 0) {
        AppToast.warnToast('Time elapsed!');
        await Future.delayed(3.5.seconds);
        _currentFinger = Finger.values[_random.nextInt(5)];
        timer.reset();
        setState();
      }
    }
  }

  void touchFinger(Finger finger) {
    if (finger == _currentFinger) {
      _correctFingerTouched();
    } else {
      _wrongSpaceTouched();
    }
  }

  void touchOpenSpace() => _wrongSpaceTouched();

  void _correctFingerTouched() {
    // Last turn - End game with win
    if (_currentTurn == config.numberOfTurns) {
      _saveWin();
      timer.removeListener(_timerListener);
      GeneralManager.i.goHome();
      AppToast.successToast('Congrats!');
    }
    // Continue game - next turn
    else {
      _currentTurn++;
      _currentFinger = Finger.values[_random.nextInt(5)];
      timer.reset();
      setState();
    }
  }

  void _wrongSpaceTouched() {
    _remainingLives--;
    setState();

    if (_remainingLives == 0) {
      // End game with loss
      timer.removeListener(_timerListener);
      GeneralManager.i.goHome();
      AppToast.errorToast('Oops! You have run out of lives');
    }
  }

  Future<void> _saveWin() async {
    final localStore = ServiceLocator.get<LocalStorageService>();
    final winsSoFar = await localStore.fetchDouble(LocalStoreKeys.wins) ?? 0;
    localStore.saveDouble(LocalStoreKeys.wins, winsSoFar + 1);
  }

  void finish() {
    timer.removeListener(_timerListener);
    GeneralManager.i.goHome();
  }
}

enum Finger {
  thumb,
  pointing,
  middle,
  ring,
  pinky;
}

class TurnTimer extends ValueNotifier<int> {
  final int seconds;
  Timer? _timer;

  TurnTimer(this.seconds) : super(seconds);

  void reset() {
    _timer?.cancel();
    value = seconds;
    start();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void start() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (timer.tick == seconds) {
          timer.cancel();
        }
        value = seconds - timer.tick;
      },
    );
  }
}
