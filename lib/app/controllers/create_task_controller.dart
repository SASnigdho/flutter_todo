import 'dart:developer';

import 'package:flutter_todo/app/data/contracts/i_task_repository.dart';
import 'package:flutter_todo/app/data/models/task_step.dart';
import 'package:get/get.dart';

import '../data/models/task.dart';
import 'base_controller.dart';

class CreateTaskController extends BaseController {
  CreateTaskController(this.repository);

  final ITaskRepository repository;

  final steps = <TaskStep>[].obs;

  Future<void> save(Task task) async {
    try {
      await repository.save(task);
    } catch (e) {
      log('CreateTaskController:: save@ $e');
    }
  }
}
