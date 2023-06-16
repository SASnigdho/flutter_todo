import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'step.g.dart';

@JsonSerializable()
@collection
class Step {
  Id? id = Isar.autoIncrement;
  int order;
  String? text;
  @JsonKey(name: 'is_completed')
  bool isCompleted;
  String? descriptions;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  Step({
    this.id,
    this.order = 0,
    this.text,
    this.isCompleted = false,
    this.descriptions,
    this.createdAt,
    this.updatedAt,
  });

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);

  Map<String, dynamic> toJson() => _$StepToJson(this);
}
