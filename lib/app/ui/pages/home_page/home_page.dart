import 'package:flutter/material.dart';
import 'package:flutter_todo/app/routes/route_names.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Tasks')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Search
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search by Title',
                ),
                onChanged: controller.searchTask,
              ),

              // List
              Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.only(top: 16),
                          shrinkWrap: true,
                          itemBuilder: (context, i) {
                            final task = controller.tasks.toList()[i];

                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Checkbox(
                                      value: task.isCompleted,
                                      onChanged: (value) async {
                                        controller.tasks
                                            .toList()[i]
                                            .isCompleted = value!;

                                        controller.tasks.refresh();
                                        await controller.updateTask(task);
                                      },
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('${task.title}',
                                            textAlign: TextAlign.left),
                                        Text(
                                          'Total Steps: ${task.steps.length}',
                                          style: Get.textTheme.labelSmall,
                                        ),
                                      ],
                                    )),
                                    CloseButton(
                                      onPressed: () async {
                                        await controller.deleteTask(task);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(),
                          itemCount: controller.tasks.length,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await Get.toNamed(RouteNames.create),
        child: const Icon(Icons.add),
      ),
    );
  }
}
