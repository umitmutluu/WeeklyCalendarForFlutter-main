import 'package:flutter/material.dart';

import '../shared/calendar_style.dart';
import '../widgets/day_table_view.dart';

import '../shared/utils.dart'
    show getWeekdays, addDay, subtractDay, firstDayOfWeek;

enum PageState {
  previous,
  current,
  next,
}

class WeekPage extends StatefulWidget {
  const WeekPage({
    super.key,
    required this.selectedDate,
    required this.now,
    required this.style,
    required this.isAutoSelect,
    required this.pageController,
    this.onChangedSelectedDate,
    this.onChangedPage,
    this.height,
  });

  final DateTime now;
  final DateTime selectedDate;
  final CalendarStyle style;
  final bool isAutoSelect;
  final PageController pageController;

  final Function(DateTime)? onChangedSelectedDate;
  final Function(DateTime date, PageState state)? onChangedPage;

  final double? height;

  @override
  State<StatefulWidget> createState() => _WeekPageState();
}

class _WeekPageState extends State<WeekPage> {
  double get height => widget.height ?? 45;
  final int initialPage = 999;
  List<int> pageCounts = [0, 1, 2];
  int currentPage = 1;
  late DateTime _currentPageDate;
  late DateTime _slectedDate;

  DateTime get now => widget.now;

  DateTime get selectedDate => widget.selectedDate;

  @override
  void initState() {
    super.initState();
    _currentPageDate = selectedDate;
    _slectedDate = selectedDate;
    widget.pageController.addListener(_pageScrollListener);
  }
  @override
  void dispose() {
    widget.pageController.removeListener(_pageScrollListener);
    super.dispose();
  }
  void _pageScrollListener (){
    if(widget.pageController.page!>999){
      widget.pageController.jumpToPage(999);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: height,
          child: pageViewBuilder(),
        ),
      ),
    );
  }

  Widget pageViewBuilder() {
    return PageView.builder(
      itemBuilder: (context, index) {
        final idx = _getIndex(index);
        return dayTable(idx);
      },
      onPageChanged: onPageChanged,
      controller: widget.pageController,
    );
  }

  Widget dayTable(int index) {
    int at = pageCounts[index] - 1;
    final weekdays = getWeekdays(now, at);
    return DayTableView(
      moodValues: widget.style.moodValues ?? [],
      weekdays: weekdays,
      onSelect: (date) {
        /// tarihe basma özelliği eklenirse
        // widget.onChangedSelectedDate?.call(date);
      },
      selectedDate: selectedDate,
      currentDate: now,
      style: widget.style,
    );
  }

  void changeSelectedDate(int value) {
    if (_pageState(value) == PageState.next) {
      _slectedDate = addDay(selectedDate, 7);
      if (widget.isAutoSelect) {
        widget.onChangedSelectedDate?.call(_slectedDate);
      }
    } else {
      _slectedDate = subtractDay(selectedDate, 7);
      if (widget.isAutoSelect) {
        widget.onChangedSelectedDate?.call(_slectedDate);
      }
    }
  }

  void updateCurrentPageDate(int value) {
    final first = firstDayOfWeek(_currentPageDate);
    final wed = addDay(first, 2);

    if (_pageState(value) == PageState.next) {
      _currentPageDate = addDay(wed, 7);
      widget.onChangedPage?.call(_currentPageDate, PageState.next);
    } else {
      _currentPageDate = subtractDay(wed, 7);
      widget.onChangedPage?.call(_currentPageDate, PageState.previous);
    }
  }

  void onPageChanged(int value) {
    changeSelectedDate(value);
    updateCurrentPageDate(value);

    int currentIndex = _getIndex(value);
    int leftIndex =
        (currentIndex - 1 < 0) ? pageCounts.length - 1 : currentIndex - 1;
    int rightIndex =
        (currentIndex + 1 > pageCounts.length - 1) ? 0 : currentIndex + 1;

    pageCounts[leftIndex] = pageCounts[currentIndex] - 1;
    pageCounts[rightIndex] = pageCounts[currentIndex] + 1;

    currentPage = pageCounts[currentIndex];
  }

  int _getIndex(int idx) {
    return (idx + 1) % pageCounts.length;
  }

  PageState _pageState(int idx) {
    final prePage = currentPage;
    final current = pageCounts[_getIndex(idx)];
    return (prePage < current) ? PageState.next : PageState.previous;
  }
}