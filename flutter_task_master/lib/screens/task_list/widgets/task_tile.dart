import 'package:flutter/material.dart';
import 'package:flutter_task_master/models/task_model.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function(bool?) onChanged;

  const TaskTile({super.key, required this.task, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Checkbox(
          value: task.status == 'concluída',
          onChanged: onChanged,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.status == 'concluída'
                ? TextDecoration.lineThrough
                : null,
          ),
        ),
        subtitle: Text(task.description),
        trailing: _buildStatusBadge(),
      ),
    );
  }

  Widget _buildStatusBadge() {
    final isDone = task.status == 'concluída';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isDone ? Colors.deepPurple[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isDone ? 'Concluída' : 'Pendente',
        style: TextStyle(
          color: isDone ? Colors.deepPurple : Colors.orange,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
