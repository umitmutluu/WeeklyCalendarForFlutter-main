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
  });

  final List<DateTime> weekdays;
  final List<MoodModel> moodValues;
  final Function(DateTime)? onSelect;
  final DateTime selectedDate;
  final DateTime currentDate;
  final CalendarStyle style;

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            ...weekdays.map(
              (date) {
                Mood? mood;
                // moodValues içindeki tarih değerleriyle uyuşan mood'u bul
                for (var moodModel in moodValues) {
                  final model = DateTime.fromMillisecondsSinceEpoch(
                      moodModel.date ?? 1712010094658);

                  if (model.year == date.year && model.month == date.month && model.day == date.day) {

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
}
