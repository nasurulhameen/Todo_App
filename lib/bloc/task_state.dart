import 'package:task_manager/pages/todo_model.dart';
import 'package:equatable/equatable.dart';

class TaskState extends Equatable {
  final List<Task> tasks;
  final TaskStatus? filter; // null=All
  final List<Task> filteredTasks;

  const TaskState({
    this.tasks = const [],
    this.filter,
    this.filteredTasks = const [],
  });

  TaskState copyWith({
    List<Task>? tasks,
    TaskStatus? filter,
    List<Task>? filteredTasks,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      filter: filter ?? this.filter,
      filteredTasks: filteredTasks ?? this.filteredTasks,
    );
  }

  @override
  List<Object?> get props => [tasks, filter ?? 'all', filteredTasks];
}
