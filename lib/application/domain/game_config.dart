class GameConfig {
  final int level;
  final Difficulty difficulty;
  final int maxFailureAllowed;
  final int randomnessSeed;
  final Hand hand;
  final int passMark;
  final int maximumScore;

  GameConfig({
    required this.level,
    required this.difficulty,
    required this.maxFailureAllowed,
    required this.randomnessSeed,
    required this.hand,
  })  : passMark = 15 + (level - 1) * 2,
        maximumScore = 25 + (level - 1) * 3,
        assert(level >= 1 && level <= 15);

  factory GameConfig.fromDifficulty({
    required int level,
    required Hand hand,
    required Difficulty difficulty,
  }) =>
      GameConfig(
        level: level,
        difficulty: difficulty,
        randomnessSeed: difficulty.randomnessSeed,
        maxFailureAllowed: 5,
        hand: hand,
      );
}

enum Hand {
  left('Left Hand'),
  right('Right Hand');

  final String description;
  const Hand(this.description);
}

enum Difficulty {
  easy(10, Duration(minutes: 6), Duration(minutes: 1, seconds: 30)),
  normal(100, Duration(minutes: 4), Duration(minutes: 1)),
  hard(200, Duration(minutes: 2), Duration(seconds: 15));

  final int randomnessSeed;
  final Duration gameTime;
  final Duration gameWarningTime;
  const Difficulty(this.randomnessSeed, this.gameTime, this.gameWarningTime);
}

enum Finger {
  thumb,
  pointing,
  middle,
  ring,
  pinky;
}
