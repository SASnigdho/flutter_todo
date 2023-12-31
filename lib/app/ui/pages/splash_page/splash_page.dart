import 'package:flutter/material.dart';
import 'package:flutter_todo/app/const/app_colors.dart';
import 'package:get/get.dart';
import '../../../controllers/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
            child: Text(
          'TODO',
          style: Get.textTheme.headlineSmall?.copyWith(
            color: AppColors.lightBg,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
