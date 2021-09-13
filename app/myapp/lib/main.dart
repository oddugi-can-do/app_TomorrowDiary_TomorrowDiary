import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'event.dart';

void main() {
  initializeDateFormatting('ko_KR', null).then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('tomorrow diary'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildTableCalendar(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit),
                      Text('${_focusedDay.day}일 편집하기'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        drawer: Container(
          color: Colors.black,
          width: 200,
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
        switch (events[0].eventState) {
          case EventState.none:
            child = Icon(Icons.star_border);
            break;
          case EventState.progressing:
            child = Icon(Icons.star_half);
            break;
          case EventState.done:
            child = Icon(Icons.star);
            break;
        }
        return child;
      },
    );
  }
}
