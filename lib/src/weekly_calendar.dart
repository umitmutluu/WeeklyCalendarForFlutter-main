import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weekly_calendar/src/config/appconfig.dart';
import 'package:weekly_calendar/src/config/gen/assets.gen.dart';

import 'shared/calendar_style.dart';
import 'widgets/footer_date_text.dart';
import 'widgets/day_of_week_view.dart';
import 'widgets/header_date_text.dart';
import 'widgets/week_page.dart';
import 'shared/utils.dart' show getBytesFromAsset, getWeekdays;

class WeeklyCalendar extends StatefulWidget {
  const WeeklyCalendar({
    super.key,
    required  this.onTap,
    this.calendarStyle = const CalendarStyle(
      moodValues: [],
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      margin: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    this.isAutoSelect = true,
    this.onChangedSelectedDate,
    this.isMonthly = false,
    this.onChangedPage,
  });

  final CalendarStyle calendarStyle;
  final bool isAutoSelect;
  final bool isMonthly;
  final VoidCallback onTap;
  final Function(DateTime)? onChangedSelectedDate;
  final Function(DateTime date, PageState state)? onChangedPage;

  @override
  State<StatefulWidget> createState() => _WeeklyCalendarState();
}

class _WeeklyCalendarState extends State<WeeklyCalendar> {
  final DateTime now = DateTime.now();
  DateTime selectedDate = DateTime.now();
  DateTime currentPageDate = DateTime.now();

  EdgeInsets get padding => widget.calendarStyle.padding;

  EdgeInsets get margin => widget.calendarStyle.margin;

  BoxDecoration get decoration => widget.calendarStyle.decoration;

  bool get isShowHeaderDateText => widget.calendarStyle.isShowHeaderDateText;

  bool get isShowFooterDateText => widget.calendarStyle.isShowFooterDateText;
  late PageController pageController;

  @override
  void initState() {
    initializeDateFormatting(widget.calendarStyle.locale);
    pageController = PageController(initialPage: 999);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:()=> widget.onTap.call(),
      child: Container(
        padding: padding,
        margin: margin,
        child: Stack(
          children: [
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(

                  decoration: decoration,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.calendarStyle.textWidget ?? const SizedBox.shrink(),
                if (isShowHeaderDateText)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          pageController.previousPage(
                              duration: Duration(milliseconds: 600),
                              curve: Curves.easeOut);
                        },
                        child: Icon(
                          Icons.chevron_left,
                          color: widget.calendarStyle.selectedCircleColor,
                        ),
                      ),
                      SizedBox(width: 12,),
                      HeaderDateText(
                          date: currentPageDate, style: widget.calendarStyle),
                      SizedBox(width: 12,),
                      if(!_isCurrentWeek())
                        GestureDetector(
                        onTap: () {
                          if (pageController.hasClients &&
                              pageController.page! < 998.9) {
                            pageController.nextPage(
                                duration: Duration(milliseconds: 600),
                                curve: Curves.easeOut);
                          }
                        },
                        child:
                        Icon(
                          Icons.chevron_right,
                          color: widget.calendarStyle.selectedCircleColor,
                        ),
                      )
                    ],
                  ),
                customDayOfWeek(),
                WeekPage(
                  onTapped:()=>widget.onTap.call(),
                  pageController: pageController,
                  height: widget.calendarStyle.height,
                  selectedDate: selectedDate,
                  now: now,
                  isMonthly: widget.isMonthly,
                  style: widget.calendarStyle,
                  isAutoSelect: widget.isAutoSelect,
                  onChangedPage: (date, state) {
                    setState(() {
                      currentPageDate = date;
                    });
                    widget.onChangedPage?.call(date, state);
                  },
                  onChangedSelectedDate: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                    widget.onChangedSelectedDate?.call(date);
                  },
                ),
                if (isShowFooterDateText)
                  FooterDateText(
                      selectedDate: selectedDate, style: widget.calendarStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }
  bool _isCurrentWeek() {
    final beginningOfWeek = now.subtract(Duration(days: now.weekday));
    final endOfWeek = beginningOfWeek.add(Duration(days: 7));
    return currentPageDate.isAfter(beginningOfWeek) &&
        currentPageDate.isBefore(endOfWeek);
  }
  Widget customDayOfWeek() {
    final weekdays = getWeekdays(now, 0);
    return DayOfWeekView(
      weekdays:
          weekdays.where((date) => date != null).cast<DateTime>().toList(),
      style: widget.calendarStyle,
    );
  }
}
