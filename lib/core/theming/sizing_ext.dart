import 'package:flutter_screenutil/flutter_screenutil.dart';

final _util = ScreenUtil();

extension Sizing on num {
  double get h => _util.setHeight(this);
  double get w => _util.setWidth(this);
  double get t => _util.setSp(this);
  double get r => _util.radius(this);
}
