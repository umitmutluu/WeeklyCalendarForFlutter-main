import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekly_calendar/src/config/gen/assets.gen.dart';
import 'package:weekly_calendar/src/widgets/day_cell.dart';

extension DateTimeExtension on DateTime {
  String toStringWithFormat(String format) => DateFormat(format).format(this);
}
extension MoodReturnWidget on Mood {
  Widget getWidget() {
    switch (this) {
      case Mood.good:
        return Assets.icons.good.svg(height: 30,width: 30);
      case Mood.calm:
        return Assets.icons.calm.svg(height: 30,width: 30);
      case Mood.unhappy:
        return Assets.icons.unhappy.svg(height: 30,width: 30);
      case Mood.awesome:
        return Assets.icons.awesome.svg(height: 30,width: 30);
      case Mood.angry:
        return Assets.icons.angry.svg(height: 30,width: 30);
      default:
        return SizedBox.shrink();
    }
  }
}