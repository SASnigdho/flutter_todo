import 'package:flutter_todo/app/data/provider/task_repository.dart';
import 'package:get/get.dart';
import '../controllers/edit_task_controller.dart';

class EditTaskBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditTaskController>(() => EditTaskController(TaskRepository()));
  }
}
