import '../../core/navigation/app_navigator.dart';
import '../ui/game_view.dart';
import '../ui/select_hand_view.dart';
import '../ui/select_level_view.dart';
import 'game.dart';
import 'game_config.dart';

class GeneralManager {
  GeneralManager._();
  static final i = GeneralManager._();

  GameLevel? _level;
  void goHome() {
    AppNavigator.main.popUntilRoute('HomeView');
  }

  void play() {
    AppNavigator.main.push(const SelectLevelView());
  }

  void selectLevel(GameLevel level) {
    _level = level;

    AppNavigator.main.push(const SelectHandView());
  }

  void selectHand(Hand hand) {
    if (_level == null) return;
    final config = GameConfig.fromLevel(hand: hand, level: _level!);
    _beginGame(config);
  }

  void _beginGame(GameConfig config) {
    final game = Game(config);
    AppNavigator.main.push(GameView(game));
  }
}
