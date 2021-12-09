import 'dart:collection';
import 'dart:math';
import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

var eat = [
  '치킨',
  '덮밥',
  '삼계탕',
  '죽',
  '칼국수',
  '간장계란밥',
  '돈까스',
  '초밥',
  '삼겹살',
  '라면',
  '김치전',
  '떡볶이',
  '회',
  '피자',
  '햄버거',
  '불고기',
  '회덮밥',
  '감자전',
  '수제비',
  '고등어',
  '갈치',
  '계란말이',
  '된장찌개',
  '김치찌개',
  '된장국',
  '순두부찌개',
];
var rnd = Random().nextInt(7);
// final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
//     key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
//     value: (item) => List.generate(
//         item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
//   ..addAll({
//     kToday: [
//       Event('Today\'s Event 1'),
//       Event('Today\'s Event 2'),
//     ],
//   });
var eventlists = [
  DateTime(2021, 12, 1),
  DateTime(2021, 12, 2),
];
final _kEventSource = Map.fromIterable(List.generate(90, (index) => index),
    key: (item) => DateTime.utc(2021, 10, item * Random().nextInt(3) + 1),
    value: (item) => List.generate(
        item % 3 + 1, (index) => Event('MENU | ${eat[Random().nextInt(25)]}')))
  ..addAll({
    kToday: [
      Event('Today\'s MENU |'),
      // Event('Today\'s MENU 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
// final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
final kLastDay = DateTime.now();
