import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/edit_task_controller.dart';

class EditTaskPage extends GetView<EditTaskController> {
  const EditTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StepsPage')),

      //
      body: const SafeArea(child: Text('StepsController')),
    );
  }
}
