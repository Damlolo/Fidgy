import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/presentation/presentation.dart';
import '../../domain/general_manager.dart';
import '../components/button_widget.dart';
import '../components/header_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          const HomeHeader(),
          // Body
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/hand_left.svg',
                      // width: 250.w,
                      height: 350.h,
                    ).animate().shake(
                          hz: 0.5,
                          curve: Curves.easeOut,
                          duration: 3.seconds,
                        ),
                    SizedBox(width: 56.w),
                    SvgPicture.asset(
                      'assets/hand_right.svg',
                      // width: 250.w,
                      height: 350.h,
                    ).animate().shake(
                          hz: 0.8,
                          delay: 0.5.seconds,
                          curve: Curves.easeOut,
                          duration: 3.seconds,
                        ),
                  ],
                ),
                SizedBox(height: 48.h),
                ButtonWidget(
                  onTap: GeneralManager.i.play,
                  label: 'PLAY',
                ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
