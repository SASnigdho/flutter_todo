import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
	int? id;
	int? order;
	String? title;
	@JsonKey(name: 'is_completed') 
	bool? isCompleted;
	String? descriptions;
	List<dynamic>? steps;
	@JsonKey(name: 'created_at') 
	String? createdAt;
	@JsonKey(name: 'updated_at') 
	String? updatedAt;

	Task({
		this.id, 
		this.order, 
		this.title, 
		this.isCompleted, 
		this.descriptions, 
		this.steps, 
		this.createdAt, 
		this.updatedAt, 
	});

	factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

	Map<String, dynamic> toJson() => _$TaskToJson(this);
}
