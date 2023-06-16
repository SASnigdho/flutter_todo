import 'package:flutter_todo/app/routes/route_names.dart';
import 'package:get/get.dart';

import 'base_controller.dart';

class SplashController extends BaseController {
  @override
  Future<void> onInit() async {
    super.onInit();

    await Future.delayed(const Duration(seconds: 2), () async {
      await Get.offAllNamed(RouteNames.home);
    });
  }
}
