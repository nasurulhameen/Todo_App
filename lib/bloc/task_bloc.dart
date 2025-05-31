import 'package:bloc/bloc.dart';
import 'package:task_manager/bloc/task_event.dart';
import 'package:task_manager/bloc/task_state.dart';
import 'package:task_manager/pages/todo_model.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super( TaskState()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<ToggleTaskStatus>(_onToggleTaskStatus);
    on<ChangeFilter>(_onChangeFilter);
  }

  void _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) {
    emit(state.copyWith(tasks: [], filteredTasks: []));
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    final updatedTasks = List<Task>.from(state.tasks)..add(event.task);
    _applyFilter(updatedTasks, state.filter, emit);
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final updatedTasks = state.tasks.map((t) {
      return t.id == event.task.id ? event.task : t;
    }).toList();
    _applyFilter(updatedTasks, state.filter, emit);
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final updatedTasks = state.tasks.where((t) => t.id != event.task.id).toList();
    _applyFilter(updatedTasks, state.filter, emit);
  }

  void _onToggleTaskStatus(ToggleTaskStatus event, Emitter<TaskState> emit) {
    final toggledTask = event.task.status == TaskStatus.pending
        ? event.task.copyWith(status: TaskStatus.completed)
        : event.task.copyWith(status: TaskStatus.pending);
    add(UpdateTask(toggledTask));
  }

  void _onChangeFilter(ChangeFilter event, Emitter<TaskState> emit) {
    _applyFilter(state.tasks, event.filter, emit);
  }

  void _applyFilter(List<Task> tasks, TaskStatus? filter, Emitter<TaskState> emit) {
    List<Task> filtered;
    if (filter == null) {
      filtered = tasks;
    } else {
      filtered = tasks.where((t) => t.status == filter).toList();
    }
    emit(state.copyWith(tasks: tasks, filter: filter, filteredTasks: filtered));
  }
}