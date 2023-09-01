class GameConfig {
  final int secondsPerTurn;
  final int numberOfTurns;
  final int maxFailureAllowed;
  final int randomnessSeed;
  final Hand hand;

  GameConfig({
    required this.secondsPerTurn,
    required this.numberOfTurns,
    required this.maxFailureAllowed,
    required this.randomnessSeed,
    required this.hand,
  });

  factory GameConfig.fromLevel({
    required Hand hand,
    required GameLevel level,
  }) =>
      GameConfig(
        secondsPerTurn: level.secondsPerTurn,
        randomnessSeed: level.randomnessSeed,
        numberOfTurns: 10,
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

enum GameLevel {
  easy(10, 15),
  normal(100, 10),
  hard(200, 5);

  final int randomnessSeed;
  final int secondsPerTurn;
  const GameLevel(this.randomnessSeed, this.secondsPerTurn);
}
