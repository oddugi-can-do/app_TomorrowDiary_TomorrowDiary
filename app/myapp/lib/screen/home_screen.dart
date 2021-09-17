// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/model/event.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  final BoxConstraints constraints;

  const HomeScreen({Key? key, required this.constraints}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _isVisibleTodayDiary = false;
  bool _isVisibleTomorrowDiary = false;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _isVisibleTodayDiary = false;
    _isVisibleTomorrowDiary = false;
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tomorrow Diary'),
        automaticallyImplyLeading: false,
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          )
        ],
      ),
      endDrawer: Container(
        color: Colors.black,
        width: 200,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTableCalendar(),
            SizedBox(height: 20),
            Visibility(
              visible: _isVisibleTodayDiary,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: TextButton(
                  child: Row(
                    children: [
                      Icon(Icons.circle_notifications),
                      SizedBox(width: 10),
                      Text(
                        '오늘의 일기를 완성해 볼까요?',
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            Visibility(
              visible: _isVisibleTomorrowDiary,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: TextButton(
                  child: Row(
                    children: [
                      Icon(Icons.circle_notifications),
                      SizedBox(width: 10),
                      Text(
                        '내일의 일기를 작성해 볼까요?',
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextButton(
                child: Row(
                  children: [
                    Icon(Icons.circle_notifications),
                    SizedBox(width: 10),
                    Text(
                      '추천 : 내일의 일기 작성을 완료하지 못했어요. \n달력에서 내일을 클릭해서 내일의 일기 작성을 시작하세요!',
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextButton(
                child: Row(
                  children: [
                    Icon(Icons.circle_notifications),
                    SizedBox(width: 10),
                    Text(
                      '팁 : 내일의 일기를 활용하는 방법(유튜브)',
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
    if (selectedDay.day == DateTime.now().day) {
      setState(() {
        _isVisibleTodayDiary = true;
      });
    } else {
      setState(() {
        _isVisibleTodayDiary = false;
      });
    }

    if (selectedDay.day == DateTime.now().day + 1) {
      setState(() {
        _isVisibleTomorrowDiary = true;
      });
    } else {
      setState(() {
        _isVisibleTomorrowDiary = false;
      });
    }
  }

  TableCalendar<Event> _buildTableCalendar() {
    return TableCalendar(
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: GoogleFonts.openSans(color: Colors.black),
        weekendStyle: GoogleFonts.openSans(color: Colors.black),
      ),
      headerStyle: HeaderStyle(titleCentered: true),
      calendarBuilders: calendarBuilder(),
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(2020, 10, 19),
      lastDay: DateTime.utc(2022, 4, 18),
      calendarFormat: _calendarFormat,
      eventLoader: _getEventsForDay,
      rangeSelectionMode: RangeSelectionMode.disabled,
      availableCalendarFormats: {CalendarFormat.month: ''},
      calendarStyle: CalendarStyle(
        defaultTextStyle: GoogleFonts.openSans(color: Colors.black),
        disabledTextStyle: GoogleFonts.openSans(color: Colors.black),
        holidayTextStyle: GoogleFonts.openSans(color: Colors.black),
        weekendTextStyle: GoogleFonts.openSans(color: Colors.black),
        selectedDecoration:
            BoxDecoration(color: Colors.black38, shape: BoxShape.circle),
        selectedTextStyle: GoogleFonts.openSans(color: Colors.white),
        outsideDaysVisible: false,
        todayDecoration:
            BoxDecoration(color: Colors.black12, shape: BoxShape.circle),
        todayTextStyle: GoogleFonts.openSans(color: Colors.white),
      ),
      locale: 'ko_KR',
      selectedDayPredicate: (day) {
        return isSameDay(day, _selectedDay);
      },
      onDaySelected: _onDaySelected,
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        _focusedDay = focusedDay;
      },
    );
  }

  CalendarBuilders<Event> calendarBuilder() {
    return CalendarBuilders(
      defaultBuilder: (context, day, focusedDay) {},
      markerBuilder: (context, dateTime, events) {
        final Widget child;
        final Icon icon;
        final double _iconSize = 20;
        switch (events[0].eventState) {
          case EventState.none:
            icon = Icon(Icons.star_border, size: _iconSize);
            break;
          case EventState.progressing:
            icon = Icon(Icons.star_half, size: _iconSize);
            break;
          case EventState.done:
            icon = Icon(Icons.star, size: _iconSize);
            break;
        }
        child = icon;
        return child;
      },
    );
  }
}
