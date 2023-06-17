import 'dart:developer';

import 'package:flutter_todo/app/data/contracts/i_task_repository.dart';
import 'package:flutter_todo/app/data/models/task.dart';
import 'package:flutter_todo/app/data/models/task_step.dart';
import 'package:get/get.dart';

import 'base_controller.dart';

class EditTaskController extends BaseController {
  EditTaskController(this.repository);

  final ITaskRepository repository;

  var task = Task();
  final steps = <TaskStep>[].obs;

  Future<void> saveTask(Task task) async {
    try {
      await repository.save(task);
    } catch (e) {
      log('EditTaskController:: saveTask@ $e');
    }
  }
}
