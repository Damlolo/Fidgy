import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../common/presentation/presentation.dart';
import '../../domain/game_clock.dart';
import '../../domain/game_config.dart';
import '../../domain/game_controller.dart';
import '../components/button_widget.dart';

class GameView extends StatelessWidget {
  const GameView(this.game, {super.key});
  final GameController game;

  @override
  Widget build(BuildContext context) {
    return AppViewBuilder(
      model: game,
      initState: (vm) => vm.startPlaying(),
      builder: (game, _) => Scaffold(
        body: Column(
          children: [
            Container(
              height: 128.h,
              padding: EdgeInsets.symmetric(
                horizontal: 80.r,
                vertical: 16.r,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LivesMeter(
                    remainingLives: game.remainingLives,
                    maxLives: game.numberOfLives,
                  ),
                  ProgressMeter(
                    levelVm: game,
                  ),
                  TimerDisplay(game.clock),
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: game.touchOpenSpace,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: game.touchOpenSpace,
                        child: Container(
                          color: AppColors.of(context).backgroundColor,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 48.r,
                      left: 48.r,
                      height: 80.r,
                      width: 250.w,
                      child: ButtonWidget(
                        onTap: game.finish,
                        label: 'Finish',
                      ),
                    ),
                    for (final finger in Finger.values)
                      Positioned(
                        top: finger.topPosition,
                        left: finger.leftPosition(game.config.hand),
                        child: FingerField(
                          finger,
                          highlight: finger == game.fingerToTap,
                          onFingerTapped: game.touchFinger,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LivesMeter extends StatelessWidget {
  const LivesMeter({
    super.key,
    required this.remainingLives,
    required this.maxLives,
  });
  final int remainingLives;
  final int maxLives;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < maxLives; i++)
          Icon(
            Icons.favorite_rounded,
            size: 64.r,
            color: AppColors.of(context).mainRed,
          )
              .animate(target: i < remainingLives ? 0 : 1)
              .scale(
                  duration: 1.seconds,
                  curve: Curves.bounceOut,
                  begin: const Offset(1, 1),
                  end: const Offset(1.4, 1.4))
              .fadeOut(begin: 1)
              .then()
              .swap(
                duration: 50.milliseconds,
                builder: (_, __) => Icon(
                  Icons.favorite_border_rounded,
                  size: 64.r,
                  color: Colors.black,
                ),
              ),
      ],
    );
  }
}

class ProgressMeter extends StatelessWidget {
  const ProgressMeter({
    super.key,
    required this.levelVm,
  });

  final GameController levelVm;

  double _starPosition(double width) {
    final starRange = (levelVm.maxScore - levelVm.firstStarScore) / 2;
    final adjustedStarNumber = levelVm.numberOfStars - 1;
    final starScore = levelVm.firstStarScore + (adjustedStarNumber * starRange);
    final starPosition = (starScore / levelVm.maxScore) * (width - 32.r);
    return starPosition;
  }

  @override
  Widget build(BuildContext context) {
    final width = 390.w;
    final height = 72.r;

    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36.r),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.of(context).textMedium,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.of(context).mainGreen,
                  borderRadius: BorderRadius.circular(36.r),
                ),
              )
                  .animate(target: levelVm.currentRawScore / levelVm.maxScore)
                  .scaleX(
                    begin: 0.1,
                    duration: 15.seconds,
                    alignment: Alignment.centerLeft,
                    curve: null,
                  ),
            ),
            // Moving star
            if (levelVm.numberOfStars != 0)
              Positioned(
                left: _starPosition(width),
                child: Icon(
                  Icons.star_rounded,
                  size: 64.r,
                  color: switch (levelVm.numberOfStars) {
                    >= 3 => AppColors.of(context).mainGreen,
                    == 2 => AppColors.of(context).mainBlue,
                    <= 1 => AppColors.of(context).mainOrange,
                    _ => null,
                  },
                ),
              ),

            // Star point markers
            if (levelVm.numberOfStars != 1)
              Positioned(
                left: (levelVm.firstStarScore / levelVm.maxScore) * width,
                child: Container(
                  width: 10.w,
                  height: height,
                  color: AppColors.of(context).mainOrange,
                ),
              ),
            if (levelVm.numberOfStars != 2)
              Positioned(
                left: (levelVm.secondStarScore / levelVm.maxScore) * width,
                child: Container(
                  width: 10.w,
                  height: height,
                  color: AppColors.of(context).mainBlue,
                ),
              ),
            if (levelVm.numberOfStars != 3)
              Positioned(
                right: 0,
                child: Container(
                  width: 10.w,
                  height: height,
                  color: AppColors.of(context).mainYellow,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TimerDisplay extends StatelessWidget {
  const TimerDisplay(this.timer, {super.key});
  final GameClock timer;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: ValueListenableBuilder(
        valueListenable: timer,
        builder: (_, timeLeft, __) => Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              timeLeft,
              style: TextStyle(
                fontSize: 54.t,
                color: timer.passedWarningPoint
                    ? AppColors.of(context).mainRed
                    : Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FingerField extends StatelessWidget {
  const FingerField(
    this.finger, {
    super.key,
    required this.highlight,
    required this.onFingerTapped,
  });

  final Finger finger;
  final bool highlight;
  final ValueChanged<Finger> onFingerTapped;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => onFingerTapped(finger),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            finger.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.t,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Animate(
            effects: highlight
                ? [
                    ScaleEffect(
                      duration: 2.5.seconds,
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1.2, 1.2),
                      curve: Curves.bounceOut,
                    ),
                    ShimmerEffect(
                      duration: 8.seconds,
                      curve: Curves.bounceInOut,
                    ),
                  ]
                : null,
            child: Container(
              height: 150.r,
              width: 150.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: highlight
                    ? AppColors.of(context).mainBlue
                    : AppColors.of(context).textMedium,
                border: Border.all(
                  color: Colors.black,
                  width: 3.r.clamp(0.4, 3.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension FingerScreenPositions on Finger {
  double get topPosition => switch (this) {
        Finger.thumb => 505.h,
        Finger.pointing => 130.h,
        Finger.middle => 21.h,
        Finger.ring => 93.h,
        Finger.pinky => 193.h,
      };

  static final leftPositions = [280.w, 457.w, 642.w, 826.w, 1009.w];
  double leftPosition(Hand hand) {
    final pos = hand == Hand.right ? leftPositions : leftPositions.reversed;
    return pos.elementAt(index);
  }
}
