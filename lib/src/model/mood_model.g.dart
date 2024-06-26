// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoodModel _$MoodModelFromJson(Map<String, dynamic> json) => MoodModel(
      idValue: (json['idValue'] as num?)?.toInt(),
      date: (json['date'] as num?)?.toInt(),
      mood: json['mood'] as String?,
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$MoodModelToJson(MoodModel instance) => <String, dynamic>{
      'idValue': instance.idValue,
      'date': instance.date,
      'mood': instance.mood,
      'image': instance.image,
      'note': instance.note,
    };
