class GameConfig {
  final int level;
  final Difficulty difficulty;
  final int maxFailureAllowed;
  final int randomnessSeed;
  final Hand hand;
  final int passMark;
  final int maximumScore;
  int get secondStarScore => passMark + (maximumScore - passMark) ~/ 2;

  GameConfig({
    required this.level,
    required this.hand,
    required this.difficulty,
  })  : passMark = 15 + (level - 1) * 2,
        maximumScore = 25 + (level - 1) * 3,
        maxFailureAllowed = 5,
        randomnessSeed = difficulty.randomnessSeed,
        assert(level >= 1 && level <= 15);

  int computeScoreStars(int score) {
    final currentRawScore = score ~/ 2;
    if (currentRawScore == maximumScore) return 3;
    if (currentRawScore >= secondStarScore) return 2;
    if (currentRawScore >= passMark) return 1;
    return 0;
  }
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
