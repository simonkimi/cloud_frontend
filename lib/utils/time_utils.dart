import 'dart:core';

extension DateTimeUtil on int {
  DateTime get byMicroseconds => DateTime.fromMicrosecondsSinceEpoch(this);

  DateTime get byMilliseconds => DateTime.fromMillisecondsSinceEpoch(this);

  DateTime get bySeconds => DateTime.fromMillisecondsSinceEpoch(this * 1000);
}
