import 'dart:math';

import '../../common/presentation/presentation.dart';
import '../ui/dialogs/game_over_dialog.dart';
import '../ui/dialogs/level_completed_dialog.dart';
import 'game_clock.dart';
import 'game_config.dart';
import 'general_manager.dart';

class GameController extends AppViewModel {
  final GameConfig config;
  final GameClock clock;
  final Random _random;

  GameController(this.config)
      : clock = GameClock(
          config.difficulty.gameTime,
          config.difficulty.gameWarningTime,
        ),
        _random = Random(config.randomnessSeed),
        _currentTurn = 0,
        _remainingLives = config.maxFailureAllowed;

  int _currentTurn;
  Finger? _currentFinger;
  int _remainingLives;

  // Live Meter data
  int get remainingLives => _remainingLives;
  int get numberOfLives => config.maxFailureAllowed;

  // Progress Meter data
  int get currentRawScore => _currentTurn;
  int get displayScore => currentRawScore * 2;
  int get maxScore => config.maximumScore;
  int get firstStarScore => config.passMark;
  int get secondStarScore => firstStarScore + (maxScore - firstStarScore) ~/ 2;
  Finger? get fingerToTap => _currentFinger;

  void startPlaying() {
    _currentTurn = -1;
    _correctFingerTouched();
    clock.addListener(_timerListener);
    clock.start();
  }

  void _timerListener() async {
    if (clock.remainingTime == Duration.zero) {
      clock.removeListener(_timerListener);
      clock.stop();

      if (currentRawScore > config.passMark) {
        LevelCompletedDialog.timeUp(levelVm: this).open();
      } else {
        GameOverDialog.timeUp().open();
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
    if (_currentTurn == config.maximumScore) {
      GeneralManager.i.gameWon(displayScore);
      clock.removeListener(_timerListener);
      clock.stop();
      LevelCompletedDialog(levelVm: this).open();
    }
    // Continue game - next turn
    else {
      _currentTurn++;
      _currentFinger = Finger.values[_random.nextInt(5)];
      setState();
    }
  }

  void _wrongSpaceTouched() {
    _remainingLives--;
    setState();

    if (_remainingLives == 0) {
      clock.removeListener(_timerListener);
      clock.stop();
      GameOverDialog.outOfLives().open();
    }
  }

  int get numberOfStars {
    if (currentRawScore == maxScore) return 3;
    if (currentRawScore >= secondStarScore) return 2;
    if (currentRawScore >= firstStarScore) return 1;
    return 0;
  }

  void finish() {
    clock.removeListener(_timerListener);
    clock.stop();
    GeneralManager.i.goHome();
  }
}
