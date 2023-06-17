import 'package:flutter/material.dart';
import 'package:flutter_todo/app/data/models/task.dart';
import 'package:get/get.dart';

import '../../../../routes/route_names.dart';

class HomeListItem extends StatelessWidget {
  const HomeListItem({
    super.key,
    required this.task,
    this.onChanged,
    required this.onDelete,
  });

  final Task task;
  final void Function(bool?)? onChanged;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          await Get.toNamed(
            RouteNames.edit,
            arguments: task,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Checkbox(
                value: task.isCompleted,
                onChanged: onChanged,

                // onChanged: (value) async {
                //   controller.tasks.toList()[i].isCompleted = value!;

                //   controller.tasks.refresh();
                //   await controller.updateTask(task);
                // },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${task.title}', textAlign: TextAlign.left),
                    Text(
                      'Total Steps: ${task.steps.length}',
                      style: Get.textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              CloseButton(
                onPressed: onDelete,

                // onPressed: () async {
                //   await controller.deleteTask(task);
                // },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
