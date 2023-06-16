import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'routes/route_names.dart';
import 'ui/pages/home_page/home_page.dart';

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

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
