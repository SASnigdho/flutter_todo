import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../data/provider/task_repository.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(TaskRepository()));
  }
}
