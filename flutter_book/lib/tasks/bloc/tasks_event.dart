part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();
}

class LoadTasks extends TasksEvent {
  @override
  List<Object> get props => [];
}

class DeleteTask extends TasksEvent {
  final int taskId;

  DeleteTask({this.taskId});

  @override
  List<Object> get props => [taskId];
}

class AddTask extends TasksEvent {
  final Task task;

  AddTask({this.task});

  @override
  List<Object> get props => [task];
}

class UpdateTask extends TasksEvent {
  final Task task;

  UpdateTask({this.task});

  @override
  List<Object> get props => [task];
}
