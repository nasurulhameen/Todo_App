import 'package:task_manager/pages/todo_model.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/pages/todo_model.dart';


abstract class TaskEvent extends Equatable {
  const TaskEvent();
  @override
  List<Object?> get props => [];
}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;
  const AddTask(this.task);
  @override
  List<Object?> get props => [task];
}

class UpdateTask extends TaskEvent {
  final Task task;
  const UpdateTask(this.task);
  @override
  List<Object?> get props => [task];
}

class DeleteTask extends TaskEvent {
  final Task task;
  const DeleteTask(this.task);
  @override
  List<Object?> get props => [task];
}

class ToggleTaskStatus extends TaskEvent {
  final Task task;
  const ToggleTaskStatus(this.task);
  @override
  List<Object?> get props => [task];
}

class ChangeFilter extends TaskEvent {
  final TaskStatus? filter; // null means All
  const ChangeFilter(this.filter);
  @override
  List<Object?> get props => [filter];
}