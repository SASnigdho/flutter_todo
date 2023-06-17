// ignore_for_file: override_on_non_overriding_member

import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../contracts/I_db_service.dart';
import '../models/task_step.dart';
import '../models/task.dart';

class DbService implements IDbService {
  late Future<Isar> _db;

  DbService() {
    _db = openDB();
  }

  Future<Isar> openDB() async {
    const dbName = 'collections';
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return Isar.openSync(
        [TaskSchema, TaskStepSchema],
        directory: dir.path,
        name: dbName,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance(dbName));
  }

  @override
  Future<List<Task>> getTasks() async {
    final tasks = <Task>[];

    try {
      final isar = await _db;
      tasks.addAll(await isar.tasks.where().findAll());

      for (final task in tasks) {
        await task.steps.load();
      }

      return tasks;
    } catch (e) {
      log('DbService:: getTasks@ $e');
    }

    return tasks;
  }

  @override
  Future<void> save(Task task) async {
    try {
      final isar = await _db;

      await isar.writeTxn(() async {
        final steps = task.steps.toList();
        await isar.taskSteps.putAll(steps);

        await isar.tasks.put(task);
        await task.steps.save();
      });
    } catch (e) {
      log('DbService:: save@ $e');
    }
  }

  @override
  Future<Task?> get(int id) async {
    try {
      final isar = await _db;
      final task = await isar.tasks.filter().idEqualTo(id).findFirst();
      await task?.steps.load();

      return task;
    } catch (e) {
      log('DbService:: get@ $e');
      return null;
    }
  }

  @override
  Future<void> delete(Task task) async {
    try {
      final isar = await _db;

      await isar.writeTxn(() async {
        await task.steps.load();

        for (final step in task.steps) {
          await isar.taskSteps.delete(step.id!);
        }

        await isar.tasks.delete(task.id!);
      });
    } catch (e) {
      log('DbService:: delete@ $e');
    }
  }
}
