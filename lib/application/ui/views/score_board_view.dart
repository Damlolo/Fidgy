import 'package:flutter/material.dart';

import '../../../common/presentation/presentation.dart';
import '../../domain/game_config.dart';
import '../../domain/game_data.dart';
import '../components/button_widget.dart';

class ScoreBoardView extends StatefulWidget {
  const ScoreBoardView({super.key});

  @override
  State<ScoreBoardView> createState() => _ScoreBoardViewState();
}

class _ScoreBoardViewState extends State<ScoreBoardView> {
  Difficulty _difficulty = Difficulty.easy;

  void _changeDifficulty(Difficulty difficulty) {
    _difficulty = difficulty;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 120.h,
        title: Text(
          'Scoreboard',
          style: TextStyle(
            fontSize: 50.t,
          ),
        ),
        backgroundColor: AppColors.defaultColors.mainOrange,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 120.h,
              child: Row(
                children: [
                  for (final difficulty in Difficulty.values)
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                          horizontal: 32.w,
                        ),
                        child: _DifficultySelectionButton(
                          difficulty: difficulty,
                          selected: _difficulty,
                          onSelect: _changeDifficulty,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: _HandScoreboard(
                    Hand.left,
                    _difficulty,
                  ),
                ),
                Expanded(
                  child: _HandScoreboard(
                    Hand.right,
                    _difficulty,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _DifficultySelectionButton extends StatelessWidget {
  const _DifficultySelectionButton({
    required this.difficulty,
    required this.selected,
    required this.onSelect,
  });
  final Difficulty difficulty;
  final Difficulty selected;
  final ValueChanged<Difficulty> onSelect;
  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      onTap: () => onSelect(difficulty),
      label: difficulty.name,
      color: selected == difficulty
          ? AppColors.defaultColors.mainGreen
          : AppColors.defaultColors.mainBlue,
    );
  }
}

class _HandScoreboard extends StatelessWidget {
  const _HandScoreboard(this.hand, this._difficulty, {super.key});
  final Hand hand;
  final Difficulty _difficulty;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          hand.description,
          style: TextStyle(fontSize: 32.t),
        ),
        for (int i = 1; i <= 15; i = i + 5)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int j = i; j <= i + 4; j++)
                _ScoreDisplay(
                    GameConfig(difficulty: _difficulty, hand: hand, level: j)),
            ],
          ),
      ],
    );
  }
}

class _ScoreDisplay extends StatelessWidget {
  const _ScoreDisplay(this.config);
  final GameConfig config;

  @override
  Widget build(BuildContext context) {
    final score = GameData.i.getScore(config);
    final stars = config.computeScoreStars(score);
    final locked = score == 0 ||
        config.level >
            GameData.i.getUnlockedLevel(
              config.difficulty,
              config.hand,
            );

    return Container(
      // height: 130.r,
      // width: 130.r,
      decoration: BoxDecoration(
        // shape: BoxShape.circle,
        borderRadius: BorderRadius.circular(20.r),
        color: locked
            ? AppColors.of(context).textMute
            : AppColors.of(context).mainBlue,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(5, 10),
          ),
        ],
      ),
      padding: EdgeInsets.all(8.r),
      margin: EdgeInsets.all(16.r),
      child: locked
          ? Icon(
              Icons.minimize_rounded,
              color: AppColors.of(context).textStrong,
              size: 56.t,
            )
          : Text(
              '${config.level} - ${'⭐️' * stars}\n$score',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.t,
                color: AppColors.of(context).textStrong,
              ),
            ),
    );
  }
}
