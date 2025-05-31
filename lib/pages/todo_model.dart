import 'package:equatable/equatable.dart';
enum TaskStatus { pending, completed }

class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final TaskStatus status;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    this.status = TaskStatus.pending,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    TaskStatus? status,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, title, description, status];
}
