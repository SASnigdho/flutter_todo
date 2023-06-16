import 'package:json_annotation/json_annotation.dart';

part 'step.g.dart';

@JsonSerializable()
class Step {
	int? id;
	@JsonKey(name: 'task_id') 
	int? taskId;
	int? order;
	String? text;
	@JsonKey(name: 'is_completed') 
	bool? isCompleted;
	String? descriptions;
	@JsonKey(name: 'created_at') 
	String? createdAt;
	@JsonKey(name: 'updated_at') 
	String? updatedAt;

	Step({
		this.id, 
		this.taskId, 
		this.order, 
		this.text, 
		this.isCompleted, 
		this.descriptions, 
		this.createdAt, 
		this.updatedAt, 
	});

	factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);

	Map<String, dynamic> toJson() => _$StepToJson(this);
}
