import 'package:flutter_book/tasks/model/task.dart';
import 'package:flutter_book/tasks/repo/tasks_provider.dart';

class TasksRepo {
  final TasksProvider _tasksProvider;
  TasksRepo({TasksProvider tasksProvider}) : _tasksProvider = tasksProvider ?? TasksProvider();

  Future<List<Task>> getAll() {
    return _tasksProvider.getAll();
  }

  Future<int> addTask(Task task) {
    return _tasksProvider.create(task);
  }

  Future<int> updateTask(Task task) {
    return _tasksProvider.update(task);
  }

  Future<int> deleteTask(int taskId) {
    return _tasksProvider.delete(taskId);
  }
}
