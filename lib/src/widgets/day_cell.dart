import 'package:flutter/material.dart';
import 'package:weekly_calendar/src/config/gen/assets.gen.dart';

import '../shared/calendar_style.dart';
import '../extension/datetime_ex.dart';

enum Mood {
  good('GOOD'),
  unhappy('UNHAPPY'),
  calm('CALM'),
  angry('ANGRY'),
  awesome('AWESOME');

  final String rawValue;

  const Mood(this.rawValue);

  // String değerini ilgili enum'a çevirmek için bir yöntem
  static Mood? fromString(String? value) {
    return Mood.values.firstWhere(
      (e) => e.rawValue == value,
      orElse: () => Mood.awesome,
    );
  }
  static Mood? fromAnswer(String? value) {
    switch (value) {
      case 'Super':
        return Mood.awesome;
      case 'Happy':
        return Mood.good;
      case 'Calm':
        return Mood.calm;
      case 'Sad':
        return Mood.unhappy;
      case 'Angry':
        return Mood.angry;
      default:
        return Mood.awesome; // veya uygun bir varsayılan değer
    }
  }
}

class DayCell extends StatelessWidget {
  const DayCell({
    super.key,
    required this.display,
    required this.selected,
    required this.current,
    required this.style,
    required this.mood,
  });

  final DateTime display;
  final DateTime selected;
  final DateTime current;
  final CalendarStyle style;
  final Mood? mood;

  String get dayText {
    return display.toStringWithFormat("d");
  }

  Color get selectedCircleColor => style.selectedCircleColor;

  Color get todaySelectedCircleColor => style.todaySelectedCircleColor;

  Color get dayTextColor => style.dayTextColor;

  Color get todayDayTextColor => style.todayDayTextColor;

  Color get selectedDayTextColor => style.selectedDayTextColor;

  Color get weekendDayTextColor => style.weekendDayTextColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(top: 4.0),
          height: 24,
          width: 24,
            decoration: BoxDecoration(
              border: mood==null?Border.all(width:0.5,color: selectedCircleColor):null,
              color: _isSelected(display)
                  ? _isToday(display)
                  ?  selectedCircleColor
                  :Colors.transparent:Colors.transparent,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child:mood?.getWidget(),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          dayText,
          style: TextStyle(
            fontSize: 12,
            fontWeight:
                 _isToday(display)? FontWeight.bold : FontWeight.w500,
            color: _dayTextColor(display),
          ),
        ),
      ],
    );
  }

  Color _dayTextColor(DateTime date) {
    if (_isSelected(date)) {
      return selectedDayTextColor;
    }

    if (_isToday(date)) {
      return todayDayTextColor;
    }

    if (_isWeekend(date)) {
      return weekendDayTextColor;
    }

    return dayTextColor;
  }

  bool _isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  bool _isSelected(DateTime date) {
    return date.toStringWithFormat("yyyyMMdd") ==
        selected.toStringWithFormat("yyyyMMdd");
  }

  bool _isToday(DateTime date) {
    return date.toStringWithFormat("yyyyMMdd") ==
        current.toStringWithFormat("yyyyMMdd");
  }
}
