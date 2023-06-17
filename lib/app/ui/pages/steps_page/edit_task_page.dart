import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/edit_task_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/models/task.dart';
import 'widgets/step_list_item.dart';

class EditTaskPage extends GetView<EditTaskController> {
  EditTaskPage({super.key}) {
    final task = Get.arguments as Task;
    _titleCtrl.text = task.title ?? '';

    controller.task = task;
    controller.steps.value = task.steps.toList();
  }

  final _taskFormKey = GlobalKey<FormState>();
  final _stepFormKey = GlobalKey<FormState>();

  final _titleCtrl = TextEditingController();
  final _stepCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        actions: [
          IconButton(
            onPressed: () async {
              if (_taskFormKey.currentState!.validate()) await _onSave();
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),

      //
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

              //
              Expanded(
                child: Obx(
                  () => ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      final step = controller.steps.toList()[i];

                      return StepListItem(
                        step: step,
                        onTap: () {
                          // TODO:: Open Edit Dialog.
                        },
                        onDelete: () {
                          controller.task.steps.remove(step);
                          controller.steps.remove(step);
                          controller.steps.refresh();
                        },
                        onChanged: (value) {
                          step.isCompleted = value!;
                          controller.steps[i] = step;
                          controller.steps.refresh();
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(),
                    itemCount: controller.steps.length,
                    padding: const EdgeInsets.only(top: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSave() async {
    try {
      controller.task.createdAt = DateTime.now().toIso8601String();
      controller.task.updatedAt = DateTime.now().toIso8601String();
      
      controller.task.newSteps.addAll(controller.steps);
      await controller.saveTask(controller.task);

      // Update home controller.
      final homeCtrl = Get.find<HomeController>();
      await homeCtrl.onInit();

      Get.back();
    } catch (e) {
      log('EditTaskPage:: _onSave@ $e');
    }
  }
}
