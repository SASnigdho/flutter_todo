import 'package:flutter/material.dart';
import 'package:flutter_todo/app/data/models/task_step.dart';

class StepListItem extends StatelessWidget {
  const StepListItem({
    super.key,
    required this.step,
    required this.onTap,
    required this.onDelete,
    required this.onChanged,
  });

  final TaskStep step;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Checkbox(
                value: step.isCompleted,
                onChanged: onChanged,
              ),
              Expanded(child: Text(step.text ?? 'Not Added')),
              CloseButton(onPressed: onDelete)
            ],
          ),
        ),
      ),
    );
  }
}
