import 'package:flutter/material.dart';
import 'package:flutter_todo/app/routes/route_names.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Tasks'),
      ),
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemBuilder: (context, i) {
                    final task = controller.tasks[i];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Checkbox(
                              value: true,
                              onChanged: (value) {},
                            ),
                            Expanded(child: Text('${task.title}')),
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
                  separatorBuilder: (context, index) => const SizedBox(),
                  itemCount: controller.tasks.length,
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
