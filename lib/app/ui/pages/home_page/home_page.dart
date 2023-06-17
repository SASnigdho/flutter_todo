import 'package:flutter/material.dart';
import 'package:flutter_todo/app/routes/route_names.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
import 'widgets/home_list_item.dart';

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

                            return HomeListItem(
                              task: task,
                              onChanged: (value) async {
                                controller.tasks.toList()[i].isCompleted =
                                    value!;

                                controller.tasks.refresh();
                                await controller.updateTask(task);
                              },
                              onDelete: () async =>
                                  await controller.deleteTask(task),
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
