import 'package:flutter/material.dart';

import '../../../common/presentation/presentation.dart';
import '../../domain/game_config.dart';
import '../../domain/game_data.dart';
import '../../domain/general_manager.dart';
import '../components/mydialog.dart';

class SelectLevelDialog extends AppDialog {
  SelectLevelDialog({
    required Hand hand,
    required Difficulty difficulty,
    super.key,
  }) : super(
          heading: 'Select a level (${difficulty.name})',
          builder: (ctx) {
            final lockPoint = GameData.i.getUnlockedLevel(difficulty, hand);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 1; i <= 15; i = i + 5)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int j = i; j <= i + 4; j++)
                        LevelButton(
                          onSelect: GeneralManager.i.selectLevel,
                          locked: j > lockPoint,
                          level: j,
                        )
                    ],
                  ),
              ],
            );
          },
        );
}

class LevelButton extends StatelessWidget {
  const LevelButton(
      {super.key,
      required this.onSelect,
      required this.locked,
      required this.level});

  final ValueChanged<int> onSelect;
  final bool locked;
  final int level;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: locked ? null : () => onSelect(level),
      child: Container(
        height: 130.r,
        width: 130.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
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
        padding: EdgeInsets.all(16.r),
        margin: EdgeInsets.all(16.r),
        child: locked
            ? Icon(
                Icons.lock,
                color: AppColors.of(context).textStrong,
                size: 56.t,
              )
            : Text(
                '$level',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 56.t, color: AppColors.of(context).textStrong),
              ),
      ),
    );
  }
}
