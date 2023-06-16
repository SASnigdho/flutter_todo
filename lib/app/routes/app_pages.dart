import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bindings/steps_binding.dart';
import '../ui/pages/home_page/home_page.dart';
import '../ui/pages/steps_page/steps_page.dart';
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
      name: RouteNames.home,
      page: () => const HomePage(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: RouteNames.steps,
      page: StepsPage.new,
      binding: StepsBinding(),
      transition: _defaultTransition,
    ),
  ];
}
