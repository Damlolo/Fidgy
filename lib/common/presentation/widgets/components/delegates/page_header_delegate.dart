import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../presentation.dart';
import '../buttons_and_ctas/app_back_button.dart';

class PageHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxSize;
  final double minSize;
  final WidgetBuilder minimizedTitle;
  final WidgetBuilder expandedWidget;
  final Widget? background;

  PageHeaderDelegate({
    required this.minimizedTitle,
    required this.expandedWidget,
    this.background,
    this.maxSize = 160 + kToolbarHeight,
    this.minSize = 72 + kToolbarHeight,
  });

  @override
  double get maxExtent => maxSize;

  @override
  double get minExtent => minSize;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();

  @override
  bool shouldRebuild(covariant PageHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final maxShrink = (maxExtent - minExtent);
    final shrink = shrinkOffset.clamp(0, maxShrink);

    final atMin = shrink >= maxShrink - 10;
    final atMax = !atMin;
    return Container(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20,
        top: kToolbarHeight,
      ),
      height: maxExtent - shrink,
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.of(context).backgroundColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(atMax ? 32 : 0),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          //? Background
          if (atMax && background != null) background!,
          //?  Main Display
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // AppIconButton.fromIconData(
                    //   onTap: AppNavigator.of(context).maybePop,
                    //   icon: Icons.keyboard_arrow_left_rounded,
                    //   iconSize: atMax ? 32 : 24.0,
                    //   size: atMax ? 40 : 32,
                    // ),
                    const AppBackButton(),
                    if (atMin)
                      Flexible(
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: const Duration(milliseconds: 600),
                          builder: (_, opacity, __) => Opacity(
                            opacity: opacity,
                            child: minimizedTitle(context),
                          ),
                        ),
                      ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              if (atMax)
                Flexible(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 24),
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 600),
                      builder: (_, opacity, __) => Opacity(
                        opacity: opacity,
                        child: expandedWidget(context),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
