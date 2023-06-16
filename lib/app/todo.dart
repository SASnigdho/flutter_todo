import 'package:flutter/material.dart';

import 'ui/pages/home_page/home_page.dart';

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
