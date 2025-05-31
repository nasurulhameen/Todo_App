import 'package:flutter/material.dart';
import '../pages/todo_model.dart';

class TaskDialog extends StatefulWidget {
  final Task? task;
  const TaskDialog({this.task, super.key});

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;

  @override
  void initState() {
    super.initState();
    _title = widget.task?.title ?? '';
    _description = widget.task?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Title is required' : null,
                onSaved: (val) => _title = val!.trim(),
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                onSaved: (val) => _description = val?.trim() ?? '',
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: const Text('Save'),
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              _formKey.currentState!.save();
              final newTask = Task(
                id: widget.task?.id ?? UniqueKey().toString(),
                title: _title,
                description: _description,
                status: widget.task?.status ?? TaskStatus.pending,
              );
              Navigator.of(context).pop(newTask);
            }
          },
        ),
      ],
    );
  }
}
