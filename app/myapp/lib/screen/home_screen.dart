// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
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
        title: const Text('tomorrow diary'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTableCalendar(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextButton(
                child: Row(
                  children: [
                    Icon(Icons.circle_notifications),
                    SizedBox(width: 10),
                    Text(
                      '내일의 일기 작성을 완료하지 못했어요.',
                      //style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
      drawer: Container(
        color: Colors.black,
        width: 200,
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
  }

  TableCalendar<Event> _buildTableCalendar() {
    return TableCalendar(
      calendarBuilders: calendarBuilder(),
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(2020, 10, 19),
      lastDay: DateTime.utc(2022, 4, 18),
      calendarFormat: _calendarFormat,
      eventLoader: _getEventsForDay,
      rangeSelectionMode: RangeSelectionMode.disabled,
      availableCalendarFormats: {CalendarFormat.month: ''},
      calendarStyle: CalendarStyle(),
      locale: 'ko_KR',
      selectedDayPredicate: (day) {
        return isSameDay(day, _selectedDay);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          // Call `setState()` when updating the selected day
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
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
