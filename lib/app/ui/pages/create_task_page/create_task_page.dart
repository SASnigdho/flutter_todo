import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_todo/app/const/app_colors.dart';
import 'package:get/get.dart';
import '../../../controllers/create_task_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/models/task_step.dart';
import '../../../data/models/task.dart';

class CreateTaskPage extends GetView<CreateTaskController> {
  CreateTaskPage({super.key});

  final _titleCtrl = TextEditingController();
  final _stepCtrl = TextEditingController();
  final _taskFormKey = GlobalKey<FormState>();
  final _stepFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create NewTask'),
        actions: [
          IconButton(
            onPressed: () {
              if (_taskFormKey.currentState!.validate()) _onSave();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Form(
                key: _taskFormKey,
                child: TextFormField(
                  controller: _titleCtrl,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter title',
                  ),
                  validator: (v) {
                    if (v!.isEmpty) return 'Enter a task name.';
                    return null;
                  },
                ),
              ),
              Obx(
                () => Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: 20),
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      final step = controller.steps.toList()[i];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: step.isCompleted,
                                onChanged: (value) {
                                  controller.steps.toList()[i].isCompleted =
                                      value!;

                                  controller.steps.refresh();
                                },
                              ),
                              Text(step.text ?? 'Not Added'),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(),
                    itemCount: controller.steps.length,
                  ),
                ),
              )
            ],
          ),
        ),
      ),

      // FloatingActionButton
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.defaultDialog(
            title: 'Add new Step',
            barrierDismissible: true,
            content: Form(
              key: _stepFormKey,
              child: TextFormField(
                controller: _stepCtrl,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter a step',
                ),
                validator: (v) {
                  if (v!.isEmpty) return 'Enter a step.';
                  return null;
                },
              ),
            ),
            cancel: TextButton(
              onPressed: Get.back,
              child: const Text('Cancel'),
            ),
            cancelTextColor: AppColors.red,
            confirm: TextButton(
              onPressed: () {
                if (_stepFormKey.currentState!.validate()) {
                  final newStep = TaskStep();
                  newStep.text = _stepCtrl.text;
                  controller.steps.add(newStep);

                  Get.back();
                  _stepCtrl.text = '';
                }
              },
              child: const Text('Add'),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _onSave() async {
    final newTask = Task();

    newTask.title = _titleCtrl.text;
    newTask.descriptions = 'Descriptions not added.';
    newTask.createdAt = DateTime.now().toIso8601String();
    newTask.updatedAt = DateTime.now().toIso8601String();

    newTask.newSteps.addAll(controller.steps.toList());

    try {
      await controller.save(newTask);

      // Update home controller.
      final homeCtrl = Get.find<HomeController>();
      await homeCtrl.onInit();
      Get.back();
    } catch (e) {
      log('CreateTaskPage:: onSave@ $e');
    }
  }
}
