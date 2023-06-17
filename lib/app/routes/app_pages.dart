import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bindings/create_task_binding.dart';
import '../bindings/edit_task_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/splash_binding.dart';
import '../ui/pages/create_task_page/create_task_page.dart';
import '../ui/pages/home_page/home_page.dart';
import '../ui/pages/splash_page/splash_page.dart';
import '../ui/pages/steps_page/edit_task_page.dart';
import 'route_names.dart';

const _defaultTransition = Transition.native;

class AppPages {
  static List<GetPage> pages = [
    GetPage(
      name: RouteNames.unknown,
      page: () => const Scaffold(
        body: Center(child: Text('Unknown route')),
      ),
    ),
    GetPage(
      name: RouteNames.splash,
      binding: SplashBinding(),
      page: () => const SplashPage(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: RouteNames.home,
      binding: HomeBinding(),
      page: () => const HomePage(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: RouteNames.create,
      binding: CreateTaskBinding(),
      page: CreateTaskPage.new,
      transition: _defaultTransition,
    ),
    GetPage(
      name: RouteNames.edit,
      binding: EditTaskBinding(),
      page: EditTaskPage.new,
      transition: _defaultTransition,
    ),
  ];
}
