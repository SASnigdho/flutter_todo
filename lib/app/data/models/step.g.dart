// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Step _$StepFromJson(Map<String, dynamic> json) => Step(
      id: json['id'] as int?,
      taskId: json['task_id'] as int?,
      order: json['order'] as int?,
      text: json['text'] as String?,
      isCompleted: json['is_completed'] as bool?,
      descriptions: json['descriptions'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$StepToJson(Step instance) => <String, dynamic>{
      'id': instance.id,
      'task_id': instance.taskId,
      'order': instance.order,
      'text': instance.text,
      'is_completed': instance.isCompleted,
      'descriptions': instance.descriptions,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
