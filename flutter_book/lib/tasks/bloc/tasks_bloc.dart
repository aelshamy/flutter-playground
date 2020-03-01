import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_book/tasks/repo/task_reop.dart';
import 'package:flutter_book/tasks/task.dart';
import 'package:intl/intl.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TasksRepo _tasksRepo;

  TasksBloc({TasksRepo tasksRepo}) : _tasksRepo = tasksRepo ?? TasksRepo();
  @override
  TasksState get initialState => TasksInitial();

  @override
  Stream<TasksState> mapEventToState(
    TasksEvent event,
  ) async* {
    if (event is LoadTasks) {
      yield* _mapLoadTasksToState();
    }

    if (event is AddTask) {
      yield* _mapAddTaskToState(event.task);
    }
    if (event is UpdateTask) {
      yield* _mapUpdateTaskToState(event.task);
    }
    if (event is DeleteTask) {
      yield* _mapDeleteNoteToState(event.taskId);
    }
  }

  Stream<TasksState> _mapLoadTasksToState() async* {
    final tasks = await _tasksRepo.getAll();
    yield TasksLoaded(tasks: tasks);
  }

  Stream<TasksState> _mapAddTaskToState(Task task) async* {
    await _tasksRepo.addTask(task);
    final tasks = await _tasksRepo.getAll();
    yield TasksLoaded(tasks: tasks);
  }

  Stream<TasksState> _mapUpdateTaskToState(Task task) async* {
    await _tasksRepo.updateTask(task);
    final tasks = await _tasksRepo.getAll();
    yield TasksLoaded(tasks: tasks);
  }

  Stream<TasksState> _mapDeleteNoteToState(int taskId) async* {
    await _tasksRepo.deleteTask(taskId);
    final tasks = await _tasksRepo.getAll();
    yield TasksLoaded(tasks: tasks);
  }

  String getDueDateAsDateTimeString(String taskDueDate) {
    if (taskDueDate != null) {
      String sDueDate;
      List dateParts = taskDueDate.split(",");
      DateTime dueDate =
          DateTime(int.parse(dateParts[2]), int.parse(dateParts[0]), int.parse(dateParts[1]));
      sDueDate = DateFormat.yMMMMd("en_US").format(dueDate.toLocal());
      return sDueDate;
    }
    return taskDueDate;
  }
}
