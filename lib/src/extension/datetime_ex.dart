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
        return Assets.icons.good.svg();
      case Mood.calm:
        return Assets.icons.calm.svg();
      case Mood.unhappy:
        return Assets.icons.unhappy.svg();
      case Mood.awesome:
        return Assets.icons.awesome.svg();
      case Mood.angry:
        return Assets.icons.angry.svg();
      default:
        return Assets.icons.good.svg();
    }
  }
}