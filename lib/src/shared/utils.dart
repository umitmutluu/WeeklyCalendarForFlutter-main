
List<DateTime> getWeekdays(DateTime date, int at) {
  final first = firstDayOfWeek(date);
  if (at >= 0) {
    return _addWeek(first, at);
  } else {
    return _subtractWeek(first, -at);
  }
}
List<DateTime> getMonthdays(DateTime date, int at) {
  final first = firstDayOfMonth(date);
  return _getFixedMonthDays(first, at);
}

List<DateTime> _getFixedMonthDays(DateTime date, int at) {
  final firstDay = addMonth(date, at);
  final daysInMonth = DateTime(firstDay.year, firstDay.month + 1, 0).day;
  final totalDays = 35; // Sabit olarak 5 hafta * 7 gün

  List<DateTime> days = List.generate(daysInMonth, (index) => index)
      .map((index) => firstDay.add(Duration(days: index)))
      .toList();

  // Fill the remaining days from the next month starting with day 1
  if (days.length < totalDays) {
    final remainingDays = totalDays - days.length;
    final nextMonth = addMonth(firstDay, 1);
    for (int i = 0; i < remainingDays; i++) {
      days.add(nextMonth.add(Duration(days: i)));
    }
  }

  return days;
}

List<DateTime> _addWeek(DateTime date, int add) {
  final day = addDay(date, 7 * add);
  return _getWeekDaysAt(day);
}

List<DateTime> _subtractWeek(DateTime date, int subtract) {
  final day = subtractDay(date, 7 * subtract);
  return _getWeekDaysAt(day);
}

DateTime addDay(DateTime date, int days) {
  return date.add(Duration(days: days));
}

DateTime subtractDay(DateTime date, int days) {
  return date.subtract(Duration(days: days));
}

DateTime addMonth(DateTime date, int months) {
  return DateTime(date.year, date.month + months, date.day);
}

DateTime subtractMonth(DateTime date, int months) {
  return DateTime(date.year, date.month - months, date.day);
}

DateTime firstDayOfWeek(DateTime date) {
  if (date.weekday == DateTime.sunday) {
    return date;
  }
  return date.subtract(Duration(days: date.weekday));
}

DateTime firstDayOfMonth(DateTime date) {
  return DateTime(date.year, date.month, 1);
}

List<DateTime> _getWeekDaysAt(DateTime date) {
  return List.generate(7, (index) => index)
      .map((index) => date.add(Duration(days: index)))
      .toList();
}
