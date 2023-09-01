import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/presentation/presentation.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'home_header',
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          color: AppColors.of(context).mainOrange,
          height: 128.h,
          padding: EdgeInsets.symmetric(
            horizontal: 104.r,
            vertical: 16.r,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _IconAndCountWidget(
                onTap: () {},
                svgPath: 'assets/flame.svg',
                count: 0,
                color: AppColors.of(context).textMedium,
              ),
              _IconAndCountWidget(
                onTap: () {},
                svgPath: 'assets/thumb.svg',
                count: 0,
                color: AppColors.of(context).textStrong,
              ),
              _IconAndCountWidget(
                onTap: () {},
                svgPath: 'assets/gear.svg',
                count: null,
                color: AppColors.of(context).textStrong,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconAndCountWidget extends StatelessWidget {
  const _IconAndCountWidget({
    required this.onTap,
    required this.svgPath,
    required this.count,
    required this.color,
  });

  final VoidCallback onTap;
  final String svgPath;
  final int? count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            svgPath,
            height: 84.r,
            width: 84.r,
          ),
          if (count != null)
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: color,
                  fontSize: 50.t,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
