import 'dart:convert';

import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'fullcalendar.dart';
import 'typedata.dart';

class CalendarAgenda extends StatefulWidget implements PreferredSizeWidget {
  final CalendarAgendaController? controller;

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function onDateSelected;

  final Color? backgroundColor;
  final SelectedDayPosition selectedDayPosition;
  final Color? selectedDateColor;
  final Color? fullCalendarBackgroundColor;
  final Color? dateColor;
  final Color? calendarBackground;
  final Color? calendarEventSelectedColor;
  final Color? calendarEventColor;
  final FullCalendarScroll fullCalendarScroll;
  final Widget? calendarLogo;
  final Widget? selectedDayLogo;
  final Widget? eventLogo;
  final Widget? selectedEventLogo;
  final Decoration? decoration;
  final Decoration? selectDecoration;

  final String? locale;
  final bool? fullCalendar;
  final WeekDay fullCalendarDay;
  final double? padding;
  final Widget? leading;
  final WeekDay weekDay;
  final bool appbar;
  final double leftMargin;
  final List<DateTime>? events;

  CalendarAgenda({
    Key? key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
    this.backgroundColor,
    this.fullCalendarBackgroundColor,
    this.selectedDayLogo,
    this.eventLogo,
    this.selectedEventLogo,
    this.decoration,
    this.selectDecoration,
    this.controller,
    this.selectedDateColor = Colors.black,
    this.dateColor = Colors.white,
    this.calendarBackground = Colors.white,
    this.calendarEventSelectedColor = Colors.white,
    this.calendarEventColor = Colors.blue,
    this.calendarLogo,
    this.locale = 'en',
    this.padding,
    this.leading,
    this.appbar = false,
    this.events,
    this.fullCalendar = true,
    this.leftMargin = 0,
    this.fullCalendarScroll = FullCalendarScroll.vertical,
    this.fullCalendarDay = WeekDay.short,
    this.weekDay = WeekDay.short,
    this.selectedDayPosition = SelectedDayPosition.left,
  })  : assert(
          initialDate.difference(firstDate).inDays >= 0,
          'initialDate must be on or after firstDate',
        ),
        assert(
          !initialDate.isAfter(lastDate),
          'initialDate must be on or before lastDate',
        ),
        assert(
          !firstDate.isAfter(lastDate),
          'lastDate must be on or after firstDate',
        ),
        super(key: key);

  @override
  CalendarAgendaState createState() => CalendarAgendaState();

  @override
  Size get preferredSize => new Size.fromHeight(250.0);
}

class CalendarAgendaState extends State<CalendarAgenda>
    with TickerProviderStateMixin {
  ItemScrollController _scrollController = new ItemScrollController();

  late Color backgroundColor;
  late double padding;
  late Widget leading;
  late double _scrollAlignment;

  List<String> _eventDates = [];
  List<DateTime> _dates = [];
  DateTime? _selectedDate;
  int? _daySelectedIndex;

  String get _locale =>
      widget.locale ?? Localizations.localeOf(context).languageCode;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting(_locale);
    _initCalendar();
    padding = widget.padding ?? 25.0;
    leading = widget.leading ?? Container();
    _scrollAlignment = widget.leftMargin / 440;

    if (widget.events != null) {
      for (var element in widget.events!) {
        _eventDates.add(element.toString().split(" ").first);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    backgroundColor = widget.backgroundColor ?? Theme.of(context).primaryColor;

    Widget dayList() {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: widget.appbar ? 125 : 110,
        padding: EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.bottomCenter,
        child: ScrollablePositionedList.builder(
            padding: _dates.length < 5
                ? EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width *
                        (5 - _dates.length) /
                        10)
                : const EdgeInsets.symmetric(horizontal: 10),
            initialScrollIndex: _daySelectedIndex ?? 0,
            // initialAlignment: _scrollAlignment,
            initialAlignment:
                widget.selectedDayPosition == SelectedDayPosition.center
                    ? 78 / 200
                    : _scrollAlignment,
            scrollDirection: Axis.horizontal,
            reverse: widget.selectedDayPosition == SelectedDayPosition.left
                ? false
                : true,
            itemScrollController: _scrollController,
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemCount: _dates.length,
            itemBuilder: (context, index) {
              DateTime date = _dates[index];
              bool isSelected = _daySelectedIndex == index;

              return Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 5.0),
                    child: GestureDetector(
                      onTap: () => _goToActualDay(index),
                      child: Container(
                        height: 120.0,
                        width: MediaQuery.of(context).size.width / 7 - 10,
                        decoration: isSelected &&
                                widget.selectDecoration != null
                            ? widget.selectDecoration!
                            : !isSelected && widget.decoration != null
                                ? widget.decoration!
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: isSelected ? Colors.white : null,
                                    boxShadow: [
                                      isSelected
                                          ? BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 10,
                                              offset: Offset(0, 3),
                                            )
                                          : BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.0),
                                              spreadRadius: 5,
                                              blurRadius: 20,
                                              offset: Offset(0, 3),
                                            )
                                    ],
                                  ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              DateFormat("dd").format(date),
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: isSelected
                                      ? widget.selectedDateColor
                                      : widget.dateColor,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w700),
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.weekDay == WeekDay.long
                                  ? DateFormat.EEEE(Locale(_locale).toString())
                                      .format(date)
                                  : DateFormat.E(Locale(_locale).toString())
                                      .format(date),
                              style: TextStyle(
                                fontSize: 12.0,
                                color: const Color(0xffA2A2B5),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            _eventDates
                                    .contains(date.toString().split(" ").first)
                                ? isSelected && widget.selectedEventLogo != null
                                    ? widget.selectedEventLogo!
                                    : (!isSelected && widget.eventLogo != null
                                        ? widget.eventLogo!
                                        : SizedBox(
                                            height: 5.0,
                                          ))
                                : SizedBox(
                                    height: 5.0,
                                  ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: widget.appbar ? 210 : 115.0,
      child: Stack(
        children: [
          Positioned(
            top: 0.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 190.0,
              color: backgroundColor,
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: dayList(),
          ),
        ],
      ),
    );
  }

  _generateDates() {
    _dates.clear();

    DateTime first = DateTime.parse(
        "${widget.firstDate.toString().split(" ").first} 00:00:00.000");

    DateTime last = DateTime.parse(
        "${widget.lastDate.toString().split(" ").first} 23:00:00.000");

    DateTime basicDate =
        DateTime.parse("${first.toString().split(" ").first} 12:00:00.000");

    List<DateTime> listDates = List.generate(
        (last.difference(first).inHours / 24).round(),
        (index) => basicDate.add(Duration(days: index)));

    widget.selectedDayPosition == SelectedDayPosition.left
        ? listDates.sort((b, a) => b.compareTo(a))
        : listDates.sort((b, a) => a.compareTo(b));

    setState(() {
      _dates = listDates;
    });
  }

  void showFullCalendar() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: widget.fullCalendarBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext context) {
        double height;
        DateTime? endDate = widget.lastDate;

        if (widget.firstDate.year == endDate.year &&
            widget.firstDate.month == endDate.month) {
          height = ((MediaQuery.of(context).size.width - 2 * padding) / 7) * 5 +
              150.0;
        } else {
          height = (MediaQuery.of(context).size.height - 100.0);
        }
        return Container(
          height: widget.fullCalendarScroll == FullCalendarScroll.vertical
              ? height
              : (MediaQuery.of(context).size.height / 7) * 4.3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Container(
                width: 60,
                height: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: Color(0xFFE0E0E0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: FullCalendar(
                  startDate: widget.firstDate,
                  endDate: endDate,
                  padding: padding,
                  dateColor: widget.dateColor,
                  dateSelectedBg: widget.calendarEventColor,
                  dateSelectedColor: widget.calendarEventSelectedColor,
                  events: _eventDates,
                  selectedDate: _selectedDate,
                  fullCalendarDay: widget.fullCalendarDay,
                  calendarScroll: widget.fullCalendarScroll,
                  calendarBackground: widget.calendarLogo,
                  locale: widget.locale,
                  onDateChange: (value) {
                    getDate(value);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _selectedDay() {
    DateTime getSelected = DateTime.parse(
        "${_selectedDate.toString().split(" ").first} 00:00:00.000");

    _daySelectedIndex = _dates.indexOf(_dates.firstWhere((dayDate) =>
        DateTime.parse("${dayDate.toString().split(" ").first} 00:00:00.000") ==
        getSelected));
  }

  _goToActualDay(int index) {
    _moveToDayIndex(index);
    setState(() {
      _daySelectedIndex = index;
      _selectedDate = _dates[index];
    });
    widget.onDateSelected(_selectedDate);
  }

  void _moveToDayIndex(int index) {
    _scrollController.scrollTo(
      index: index,
      alignment: widget.selectedDayPosition == SelectedDayPosition.center
          ? 78 / 200
          : _scrollAlignment,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void getDate(DateTime value) {
    setState(() {
      _selectedDate = value;
    });
    _selectedDay();
    _goToActualDay(_daySelectedIndex!);
  }

  _initCalendar() {
    if (widget.controller != null &&
        widget.controller is CalendarAgendaController) {
      widget.controller!.bindState(this);
    }
    _selectedDate = widget.initialDate;
    _generateDates();
    _selectedDay();
  }
}
