import 'dart:developer';

import 'package:flutter_todo/app/data/contracts/i_task_repository.dart';
import 'package:flutter_todo/app/data/models/task.dart';

import 'repository.dart';

class TaskRepository extends Repository implements ITaskRepository {
  @override
  Future<void> delete(Task task) async {
    try {
      await db.delete(task);
    } catch (e) {
      log('TaskRepository:: delete@ $e');
    }
  }

  @override
  Future<Task?> get(int id) async {
    try {
      final task = await db.get(id);

      return task;
    } catch (e) {
      log('TaskRepository:: get@ $e');
      return null;
    }
  }

  @override
  Future<List<Task>> getTasks() async {
    final tasks = <Task>[];

    try {
      tasks.addAll(await db.getTasks());

      return tasks;
    } catch (e) {
      log('TaskRepository:: getTasks@ $e');
      return tasks;
    }
  }

  @override
  Future<void> save(Task task) async {
    try {
      await db.save(task);
    } catch (e) {
      log('TaskRepository:: save@ $e');
    }
  }
}
