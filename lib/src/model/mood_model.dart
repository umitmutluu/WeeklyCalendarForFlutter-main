import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'mood_model.g.dart';

@JsonSerializable()
class MoodModel with EquatableMixin {
  @JsonKey(name: 'date')
  int? date;
  @JsonKey(name: 'mood')
  String? mood;
  @JsonKey(name: 'image')
  List<int>? image;
  @JsonKey(name: 'note')
  String? note;

  MoodModel({
    this.date,
    this.mood,
    this.image,
    this.note,
  });

  factory MoodModel.fromJson(Map<String, dynamic> json) =>
      _$MoodModelFromJson(json);

  Map<String, dynamic> toJson() => _$MoodModelToJson(this);

  @override
  List<Object?> get props => [date, mood, image, note];

  MoodModel copyWith({
    int? date,
    String? mood,
    List<int>? image,
    String? note,
  }) {
    return MoodModel(
      date: date ?? this.date,
      mood: mood ?? this.mood,
      image: image ?? this.image,
      note: note ?? this.note,
    );
  }
}
