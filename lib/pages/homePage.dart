import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:task_manager/bloc/task_bloc.dart';
import 'package:task_manager/bloc/task_event.dart';
import 'package:task_manager/bloc/task_state.dart';
import 'package:task_manager/pages/welcome.dart';
import 'package:task_manager/widget/task_dialog.dart';

import 'todo_model.dart';

class TaskHomePage extends StatelessWidget {
  const TaskHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.insert_chart),
            tooltip: 'Statistics',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StatsPage()),
            ),
          )
        ],
      ),
      body: Column(
        children: const [
          _FilterBar(),
          Expanded(child: _TaskList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await showDialog<Task>(
            context: context,
            builder: (_) => const TaskDialog(),
          );
          if (newTask != null) {
            bloc.add(AddTask(newTask));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskBloc>();
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8,
            children: [
              FilterChip(
                label: const Text('All'),
                selected: state.filter == null,
                onSelected: (_) => bloc.add(const ChangeFilter(null)),
              ),
              FilterChip(
                label: const Text('Pending'),
                selected: state.filter == TaskStatus.pending,
                onSelected: (_) => bloc.add(const ChangeFilter(TaskStatus.pending)),
              ),
              FilterChip(
                label: const Text('Completed'),
                selected: state.filter == TaskStatus.completed,
                onSelected: (_) => bloc.add(const ChangeFilter(TaskStatus.completed)),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TaskList extends StatelessWidget {
  const _TaskList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state.filteredTasks.isEmpty) {
          return const Center(child: Text('No tasks found.'));
        }
        return ListView.builder(
          itemCount: state.filteredTasks.length,
          itemBuilder: (context, index) {
            final task = state.filteredTasks[index];
            return Slidable(
              key: ValueKey(task.id),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    label: 'Edit',
                    backgroundColor: Colors.blue,
                    icon: Icons.edit,
                    onPressed: (_) async {
                      final updatedTask = await showDialog<Task>(
                        context: context,
                        builder: (_) => TaskDialog(task: task),
                      );
                      if (updatedTask != null) {
                        context.read<TaskBloc>().add(UpdateTask(updatedTask));
                      }
                    },
                  ),
                  SlidableAction(
                    label: 'Delete',
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                    onPressed: (_) {
                      context.read<TaskBloc>().add(DeleteTask(task));
                    },
                  ),
                ],
              ),
              child: ListTile(
                leading: Checkbox(
                  value: task.status == TaskStatus.completed,
                  onChanged: (_) {
                    context.read<TaskBloc>().add(ToggleTaskStatus(task));
                  },
                ),
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.status == TaskStatus.completed
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                subtitle: task.description.isNotEmpty ? Text(task.description) : null,
              ),
            );
          },
        );
      },
    );
  }
}
