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

  final _taskFormKey = GlobalKey<FormState>();
  final _stepFormKey = GlobalKey<FormState>();

  final _titleCtrl = TextEditingController();
  final _stepCtrl = TextEditingController();

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
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () async {
                            _stepCtrl.text = step.text ?? 'N/a';

                            await _stepDialog(
                              title: 'Edit Step',
                              onConfirm: () {
                                if (_stepFormKey.currentState!.validate()) {
                                  controller.steps.toList()[i].text =
                                      _stepCtrl.text;

                                  Get.back();
                                  _stepCtrl.text = '';
                                  controller.steps.refresh();
                                }
                              },
                            );
                          },
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
                                Expanded(child: Text(step.text ?? 'Not Added')),
                                CloseButton(
                                  onPressed: () {
                                    controller.steps.remove(step);
                                    controller.steps.refresh();
                                  },
                                ),
                              ],
                            ),
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
          await _stepDialog(
            onConfirm: () {
              if (_stepFormKey.currentState!.validate()) {
                final newStep = TaskStep();
                newStep.text = _stepCtrl.text;
                controller.steps.add(newStep);

                Get.back();
                _stepCtrl.text = '';
              }
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _stepDialog({
    VoidCallback? onConfirm,
    String title = 'Add new Step',
  }) async {
    await Get.defaultDialog(
      title: title,
      barrierDismissible: false,
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
      confirm: TextButton(onPressed: onConfirm, child: const Text('Add')),
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
