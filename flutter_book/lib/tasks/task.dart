import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final String description;
  final String dueDate;
  final bool completed;

  Task({this.id, this.description, this.dueDate, this.completed = false});

  factory Task.fromMap(Map<String, dynamic> inMap) => Task(
        id: inMap["id"],
        description: inMap["description"],
        dueDate: inMap["dueDate"],
        completed: inMap["completed"].toLowerCase() == 'true',
      );

  Map<String, dynamic> toMap(Task task) {
    return {
      "id": task.id,
      "description": task.description,
      "dueDate": task.dueDate,
      "completed": task.completed.toString(),
    };
  }

  Task copyWith({
    int id,
    String description,
    String dueDate,
    bool completed,
  }) =>
      Task(
        id: id ?? this.id,
        description: description ?? this.description,
        dueDate: dueDate ?? this.dueDate,
        completed: completed ?? this.completed,
      );

  @override
  String toString() {
    return "{ id=$id, description=$description, dueDate=$dueDate, completed=$completed }";
  }

  @override
  List<Object> get props => [id, description, dueDate, completed];
}
