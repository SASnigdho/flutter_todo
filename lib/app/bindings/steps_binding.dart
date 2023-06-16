
import 'package:get/get.dart';
import '../controllers/steps_controller.dart';


class StepsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StepsController>(() => StepsController());
  }
}