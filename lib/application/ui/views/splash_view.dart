import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../common/presentation/presentation.dart';
import '../../domain/game_data.dart';
import 'home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    GameData.i.initialise();
    _startSplashTimer();
    super.initState();
  }

  void _startSplashTimer() {
    Future.delayed(const Duration(seconds: 4), () {
      AppNavigator.main.push(const HomeView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).mainGreen,
      body: Center(
        child: Text(
          'fidgy',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 128.t,
            color: AppColors.of(context).textStrong,
          ),
        ).animate().shake(
              curve: Curves.easeOutQuad,
              duration: 3.seconds,
              hz: 1,
            ),
      ),
    );
  }
}
