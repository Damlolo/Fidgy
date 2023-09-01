import 'dart:math' as math;

import 'package:intl/intl.dart';

extension NumExtension on num {
  num get mbToBytes => this * math.pow(1024, 2);

  /// A method returns a human readable string representing a file _size
  String asFileSizeText([int round = 2]) {
    /** 
   * [size] can be passed as number or as string
   *
   * the optional parameter [round] specifies the number 
   * of digits after comma/point (default is 2)
   */
    var divider = 1024;
    int sizeAsText;
    try {
      sizeAsText = int.parse(toString());
    } catch (e) {
      throw ArgumentError('Can not parse the size parameter: $e');
    }

    if (sizeAsText < divider) {
      return '$sizeAsText B';
    }

    if (sizeAsText < math.pow(divider, 2) && sizeAsText % divider == 0) {
      return '${(sizeAsText / divider).toStringAsFixed(0)} KB';
    }

    if (sizeAsText < math.pow(divider, 2)) {
      return '${(sizeAsText / divider).toStringAsFixed(round)} KB';
    }

    if (sizeAsText < math.pow(divider, 3) && sizeAsText % divider == 0) {
      return '${(sizeAsText / math.pow(divider, 2)).toStringAsFixed(0)} MB';
    }

    if (sizeAsText < math.pow(divider, 3)) {
      return '${(sizeAsText / math.pow(divider, 2)).toStringAsFixed(round)} MB';
    }

    if (sizeAsText < math.pow(divider, 4) && sizeAsText % divider == 0) {
      return '${(sizeAsText / math.pow(divider, 3)).toStringAsFixed(0)} GB';
    }

    if (sizeAsText < math.pow(divider, 4)) {
      return '${(sizeAsText / math.pow(divider, 3)).toStringAsFixed(round)} GB';
    }

    if (sizeAsText < math.pow(divider, 5) && sizeAsText % divider == 0) {
      num r = sizeAsText / math.pow(divider, 4);
      return '${r.toStringAsFixed(0)} TB';
    }

    if (sizeAsText < math.pow(divider, 5)) {
      num r = sizeAsText / math.pow(divider, 4);
      return '${r.toStringAsFixed(round)} TB';
    }

    if (sizeAsText < math.pow(divider, 6) && sizeAsText % divider == 0) {
      num r = sizeAsText / math.pow(divider, 5);
      return '${r.toStringAsFixed(0)} PB';
    } else {
      num r = sizeAsText / math.pow(divider, 5);
      return '${r.toStringAsFixed(round)} PB';
    }
  }

  String formatAsCurrency() {
    return NumberFormat.currency(symbol: '').format(this);
  }
}
