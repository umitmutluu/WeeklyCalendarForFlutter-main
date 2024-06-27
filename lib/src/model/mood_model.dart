import 'dart:collection';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:weekly_calendar/src/config/appconfig.dart';

part 'mood_model.g.dart';


class Uint8ListConverter implements JsonConverter<Uint8List?, List<int>?> {
  const Uint8ListConverter();

  @override
  Uint8List? fromJson(List<int>? json) {
    return json != null ? Uint8List.fromList(json) : null;
  }

  @override
  List<int>? toJson(Uint8List? object) {
    return object?.toList();
  }
}
@JsonSerializable()
@Uint8ListConverter()
class MoodModel with EquatableMixin {

  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'date')
  int? date;
  @JsonKey(name: 'mood')
  String? mood;
  @JsonKey(name: 'image')
  Uint8List? image;
  @JsonKey(name: 'note')
  String? note;

  MoodModel({
    this.id,
    this.date,
    this.mood,
    this.image,
    this.note,
  });

  factory MoodModel.fromJson(Map<String, dynamic> json) =>
      _$MoodModelFromJson(json);

  Map<String, dynamic> toJson() => _$MoodModelToJson(this);

  @override
  List<Object?> get props => [id,date, mood, image, note];

  MoodModel copyWith({
    int? id,
    int? date,
    String? mood,
    Uint8List? image,
    String? note,
  }) {
    return MoodModel(
      id: id ?? this.id,
      date: date ?? this.date,
      mood: mood ?? this.mood,
      image: image ?? this.image ?? AppConfig.defaultByte,
      note: note ?? this.note,
    );
  }
}

// Event yerine MoodModel kullanımı
final kEvents = LinkedHashMap<DateTime, List<MoodModel>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1,
        (index) => MoodModel(
            date: item,
            mood: 'Mood $item | ${index + 1}',
            note: 'Note for event $item')))
  ..addAll({
    kToday: [
      MoodModel(
          date: kToday.millisecondsSinceEpoch,
          mood: 'Happy',
          note: 'Today\'s Event 1'),
      MoodModel(
          date: kToday.millisecondsSinceEpoch,
          mood: 'Sad',
          note: 'Today\'s Event 2'),
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
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

bool isSameDay(DateTime? a, DateTime? b) {
  if (a == null || b == null) {
    return false;
  }

  return a.year == b.year && a.month == b.month && a.day == b.day;
}
