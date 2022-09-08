import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

@immutable
class Task with ChangeNotifier {
  final String id;
  final String taskName;
  final String taskDescription;
  final String imageUrl;

  Task({
    required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.imageUrl,
  });

  @override
  String toString() {
    return 'Task(taskName : $taskName, taskDescription : $taskDescription, imageUrl : $imageUrl)';
  }
}

class TaskList extends StateNotifier<List<Task>> {
  TaskList([List<Task>? initialTasks]) : super(initialTasks ?? []);

  void addTask(String taskName, String taskDescription, String imageUrl) {
    state = [
      ...state,
      Task(
          id: _uuid.v4(),
          taskName: taskName,
          taskDescription: taskDescription,
          imageUrl: imageUrl)
    ];
  }

  void removeTask(Task target) {
    state = state.where((task) => task.id != target.id).toList();
  }
}
