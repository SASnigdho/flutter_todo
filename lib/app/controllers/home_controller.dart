import 'dart:developer';

import 'package:flutter_todo/app/data/contracts/i_task_repository.dart';
import 'package:get/get.dart';

import '../data/models/task.dart';
import 'base_controller.dart';

class HomeController extends BaseController {
  HomeController(this.repository);

  final ITaskRepository repository;

  final tasks = <Task>[].obs;
  final isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    await getsTasks();
  }

  Future<void> getsTasks() async {
    isLoading.value = true;
    tasks.clear();

    try {
      final tasks = await repository.getTasks();

      this.tasks.addAll(tasks);
      isLoading.value = false;
    } catch (e) {
      log('HomeController:: getsTasks@ $e');
      isLoading.value = false;
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await repository.save(task);
    } catch (e) {
      log('HomeController:: updateTask@ $e');
      isLoading.value = false;
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await repository.delete(task);
      await getsTasks();
    } catch (e) {
      log('HomeController:: deleteTask@ $e');
      isLoading.value = false;
    }
  }

  Future<void> searchTask(String keyword) async {
    final searchResult = <Task>[];
    try {
      for (var task in tasks) {
        if (task.title!.contains(keyword)) {
          searchResult.add(task);
        }
      }
      tasks.clear();
      tasks.addAll(searchResult);
      tasks.refresh();

      if (keyword.isEmpty) {
        await getsTasks();
      }
    } catch (e) {
      log('HomeController:: searchTask@ $e');
      isLoading.value = false;
    }
  }
}
