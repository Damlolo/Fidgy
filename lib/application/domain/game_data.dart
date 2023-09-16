import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import '../../common/presentation/presentation.dart';
import 'game_config.dart';

class GameData extends AppViewModel {
  GameData._();
  static final i = GameData._();
  static const dataKey = 'DATA_KEY';
  static const gameCountKey = 'GAME_COUNT';

  int _gameCount = 0;
  var _data = <Hand, Map<Difficulty, Map<int, int>>>{
    Hand.left: {
      Difficulty.easy: {},
      Difficulty.normal: {},
      Difficulty.hard: {},
    },
    Hand.right: {
      Difficulty.easy: {},
      Difficulty.normal: {},
      Difficulty.hard: {},
    }
  };

  int get gameCount => _gameCount;

  void initialise() async {
    final sp = await SharedPreferences.getInstance();
    final gameCount = sp.getInt(gameCountKey);
    _gameCount = gameCount ?? 0;
    final rawString = sp.getString(dataKey);
    if (rawString == null) return;
    final rawData = jsonDecode(rawString);

    _data = (rawData as Map).map(
      (handi, rec) => MapEntry(
        Hand.values[handi],
        rec.map(
          (difficultyi, details) => MapEntry(
            Difficulty.values[difficultyi],
            details,
          ),
        ),
      ),
    );
  }

  int getUnlockedLevel(Difficulty difficulty, Hand hand) {
    try {
      final records = _data[hand]![difficulty]!;
      final levels = records.keys;
      if (levels.isEmpty) return 1;
      final unlocked = levels.reduce(max);
      return unlocked + 1;
    } catch (_) {}
    return 1;
  }

  void recordScore(GameRecord record) {
    final dataRecord = _data[record.hand]![record.difficulty]!;
    final lastScore = dataRecord[record.level];
    _gameCount++;
    if (lastScore == null || lastScore < record.score) {
      dataRecord[record.level] = record.score;
    }
    _updateDb();
  }

  Future<void> _updateDb() async {
    final sp = await SharedPreferences.getInstance();
    sp.setInt(gameCountKey, _gameCount);

    final encodedData = _data.map(
      (hand, rec) => MapEntry(
        hand.index,
        rec.map(
          (difficulty, details) => MapEntry(
            difficulty.index,
            details,
          ),
        ),
      ),
    );
    // sp.setString(
    //   dataKey,
    //   encodedData.toString(),
    // );
    setState();
  }
}

class GameRecord {
  final Hand hand;
  final Difficulty difficulty;
  final int level;
  final int score;

  GameRecord(this.hand, this.difficulty, this.level, this.score);
}
