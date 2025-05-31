import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/pages/homePage.dart';
import 'package:task_manager/bloc/task_bloc.dart';
import 'package:task_manager/bloc/task_event.dart';


void main() {
  runApp(BlocProvider(
    create: (_) => TaskBloc()..add(LoadTasks()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const TaskHomePage(),
    );
  }
}
