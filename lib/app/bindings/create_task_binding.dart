import 'package:get/get.dart';
import '../controllers/create_task_controller.dart';
import '../data/provider/task_repository.dart';

class CreateTaskBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateTaskController>(
      () => CreateTaskController(TaskRepository()),
    );
  }
}
