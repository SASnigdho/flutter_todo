import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/steps_controller.dart';

class StepsPage extends GetView<StepsController> {
  const StepsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StepsPage')),

      //
      body: const SafeArea(child: Text('StepsController')),
    );
  }
}
