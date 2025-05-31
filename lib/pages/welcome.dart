import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:task_manager/bloc/task_bloc.dart';
import 'package:task_manager/bloc/task_state.dart';

import 'todo_model.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          final total = state.tasks.length;
          final completed =
              state.tasks.where((t) => t.status == TaskStatus.completed).length;
          final pending = total - completed;
          final completedPercent = total == 0 ? 0 : completed / total;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircularPercentIndicator(
                  radius: 120,
                  lineWidth: 15,
                  // percent: completedPercent,
                  center:
                      Text('${(completedPercent * 100).toStringAsFixed(1)}%'),
                  progressColor: Colors.green,
                  backgroundColor: Colors.grey.shade300,
                  animation: true,
                ),
                const SizedBox(height: 24),
                Text('Total Tasks: $total',
                    style: const TextStyle(fontSize: 18)),
                Text('Completed: $completed',
                    style: const TextStyle(fontSize: 18)),
                Text('Pending: $pending', style: const TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }
}
