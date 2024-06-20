import 'package:flutter/material.dart';
import 'package:weekly_calendar/src/model/mood_model.dart';

import '../shared/calendar_style.dart';
import '../widgets/day_cell.dart';

class DayTableView extends StatelessWidget {
  const DayTableView({
    super.key,
    required this.weekdays,
    required this.onSelect,
    required this.selectedDate,
    required this.currentDate,
    required this.style,
    required this.moodValues,
    this.isMonthly = false,
  });

  final List<DateTime> weekdays;
  final List<MoodModel> moodValues;
  final Function(DateTime)? onSelect;
  final DateTime selectedDate;
  final DateTime currentDate;
  final CalendarStyle style;
  final bool isMonthly;

  @override
  Widget build(BuildContext context) {
    if (isMonthly) {
      return _buildMonthlyView();
    } else {
      return _buildWeeklyView();
    }
  }

  Widget _buildWeeklyView() {
    return Table(
      children: [
        TableRow(
          children: [
            ...weekdays.map(
                  (date) {
                Mood? mood;
                for (var moodModel in moodValues) {
                  final model = DateTime.fromMillisecondsSinceEpoch(
                      moodModel.date ?? 1712010094658);

                  if (model.year == date.year &&
                      model.month == date.month &&
                      model.day == date.day) {
                    mood = Mood.fromString(moodModel.mood);
                    break;
                  }
                }
                return GestureDetector(
                  onTap: () => onSelect?.call(date),
                  child: DayCell(
                    mood: mood,
                    display: date,
                    selected: selectedDate,
                    current: currentDate,
                    style: style,
                  ),
                );
              },
            ).toList(),
          ],
        ),
      ],
    );
  }

  Widget _buildMonthlyView() {
    final weeks = <List<DateTime>>[];
    for (int i = 0; i < weekdays.length; i += 7) {
      weeks.add(weekdays.sublist(
          i, i + 7 > weekdays.length ? weekdays.length : i + 7));
    }

    return Column(
      children: weeks.map((week) {
        return Table(

          children: [
            TableRow(
              children: week.map((date) {
                Mood? mood;
                for (var moodModel in moodValues) {
                  final model = DateTime.fromMillisecondsSinceEpoch(
                      moodModel.date ?? 1712010094658);

                  if (model.year == date.year &&
                      model.month == date.month &&
                      model.day == date.day) {
                    mood = Mood.fromString(moodModel.mood);
                    break;
                  }
                }
                return GestureDetector(
                  onTap: () => onSelect?.call(date),
                  child: DayCell(
                    mood: mood,
                    display: date,
                    selected: selectedDate,
                    current: currentDate,
                    style: style,
                  ),
                );
              }).toList(),
            ),
          ],
        );
      }).toList(),
    );
  }

}