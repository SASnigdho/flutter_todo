// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as int?,
      order: json['order'] as int?,
      title: json['title'] as String?,
      isCompleted: json['is_completed'] as bool?,
      descriptions: json['descriptions'] as String?,
      steps: json['steps'] as List<dynamic>?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'title': instance.title,
      'is_completed': instance.isCompleted,
      'descriptions': instance.descriptions,
      'steps': instance.steps,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
