import 'package:flutter_todo/app/data/models/step.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
@collection
class Task {
  Id? id = Isar.autoIncrement;
  int order;
  String? title;
  @JsonKey(name: 'is_completed')
  bool isCompleted;
  String? descriptions;
  final steps = IsarLinks<Step>();
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  Task({
    this.id,
    this.order = 0,
    this.title,
    this.isCompleted = false,
    this.descriptions,
    this.createdAt,
    this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
