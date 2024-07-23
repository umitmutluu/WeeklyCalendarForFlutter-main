import 'dart:collection';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:weekly_calendar/src/config/appconfig.dart';

part 'mood_model.g.dart';


@JsonSerializable()
class MoodModel with EquatableMixin {

  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'date')
  int? date;
  @JsonKey(name: 'mood')
  String? mood;
  @JsonKey(name: 'note')
  String? note;

  MoodModel({
    this.id,
    this.date,
    this.mood,
    this.note,
  });

  factory MoodModel.fromJson(Map<String, dynamic> json) =>
      _$MoodModelFromJson(json);

  Map<String, dynamic> toJson() => _$MoodModelToJson(this);

  @override
  List<Object?> get props => [id,date, mood, note];

  MoodModel copyWith({
    int? id,
    int? date,
    String? mood,
    String? note,
  }) {
    return MoodModel(
      id: id ?? this.id,
      date: date ?? this.date,
      mood: mood ?? this.mood,
      note: note ?? this.note,
    );
  }
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
final now = DateTime.now();
final kFirstDay = DateTime(now.year-1, now.month , now.day);
final DateTime kLastDay = DateTime(now.year, now.month + 1, 0);

bool isSameDay(DateTime? a, DateTime? b) {
  if (a == null || b == null) {
    return false;
  }

  return a.year == b.year && a.month == b.month && a.day == b.day;
}
