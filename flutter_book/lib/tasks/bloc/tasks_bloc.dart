import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_book/tasks/repo/task_reop.dart';
import 'package:flutter_book/tasks/task.dart';
import 'package:intl/intl.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TasksRepo _tasksRepo;
  TasksBloc({TasksRepo? tasksRepo})
      : _tasksRepo = tasksRepo ?? TasksRepo(),
        super(TasksInitial()) {
    on<LoadTasks>((event, emit) async {
      final tasks = await _tasksRepo.getAll();
      emit(TasksLoaded(tasks: tasks));
    });
    on<AddTask>((event, emit) async {
      await _tasksRepo.addTask(event.task);
      final tasks = await _tasksRepo.getAll();
      emit(TasksLoaded(tasks: tasks));
    });
    on<UpdateTask>((event, emit) async {
      await _tasksRepo.updateTask(event.task);
      final tasks = await _tasksRepo.getAll();
      emit(TasksLoaded(tasks: tasks));
    });
    on<DeleteTask>((event, emit) async {
      await _tasksRepo.deleteTask(event.taskId);
      final tasks = await _tasksRepo.getAll();
      emit(TasksLoaded(tasks: tasks));
    });
  }

  String getDueDateAsDateTimeString(String taskDueDate) {
    String sDueDate;
    List dateParts = taskDueDate.split(",");
    DateTime dueDate = DateTime(int.parse(dateParts[2]),
        int.parse(dateParts[0]), int.parse(dateParts[1]));
    sDueDate = DateFormat.yMMMMd("en_US").format(dueDate.toLocal());
    return sDueDate;
  }
}
