// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoodModel _$MoodModelFromJson(Map<String, dynamic> json) => MoodModel(
      id: (json['id'] as num?)?.toInt(),
      date: (json['date'] as num?)?.toInt(),
      mood: json['mood'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$MoodModelToJson(MoodModel instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'mood': instance.mood,
      'note': instance.note,
    };
