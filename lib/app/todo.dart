// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_todo/app/bindings/splash_binding.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'routes/route_names.dart';
import 'ui/theme/light.dart';

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TODO App',
      debugShowCheckedModeBanner: false,

      // Routing.
      initialRoute: RouteNames.splash,
      getPages: AppPages.pages,
      builder: (_, child) => child!,
      unknownRoute: AppPages.pages.first,

      theme: AppTheme.light,
    );
  }
}
