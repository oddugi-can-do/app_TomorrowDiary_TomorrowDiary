import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  final EventState eventState;

  Event(this.title, {this.eventState = EventState.none});

  @override
  String toString() => title;
}

/*
EventState.none : 아직 쓰여진 일기가 없을 때
EventState.progressing : 미래일기만 쓰여졌을 때
EventState.done : 일기가 완성 되었을 때
*/
enum EventState { none, progressing, done }

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final _kEventSource = Map.fromIterable(List.generate(500, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 1),
    value: (item) => List.generate(1, (index) {
          EventState _state;
          if (item % 3 == 0) {
            _state = EventState.none;
          } else if (item % 3 == 1) {
            _state = EventState.progressing;
          } else {
            _state = EventState.done;
          }
          return Event('Event $item | ${index + 1}', eventState: _state);
        }));

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
