import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_book/tasks/bloc/tasks_bloc.dart';
import 'package:flutter_book/tasks/task.dart';
import 'package:flutter_book/tasks/ui/task_item.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          if (state is TasksLoaded) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (BuildContext context, int inIndex) {
                Task task = state.tasks[inIndex];

                return Dismissible(
                  key: ValueKey(task.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.only(right: 10),
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.delete),
                  ),
                  confirmDismiss: (direction) =>
                      _confirmDismiss(context, task.description ?? ""),
                  onDismissed: (direction) => _deleteTask(context, task),
                  child: ListTile(
                    leading: Checkbox(
                      value: task.completed,
                      onChanged: (bool? inValue) async {
                        BlocProvider.of<TasksBloc>(context).add(
                          UpdateTask(
                            task: task.copyWith(completed: inValue!),
                          ),
                        );
                      },
                    ),
                    title: Text(
                      task.description ?? "",
                      style: task.completed
                          ? TextStyle(
                              color: Theme.of(context).disabledColor,
                              decoration: TextDecoration.lineThrough)
                          : TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline1?.color,
                            ),
                    ),
                    subtitle: task.dueDate == null
                        ? null
                        : Text(
                            task.dueDate ?? "",
                            style: task.completed
                                ? TextStyle(
                                    color: Theme.of(context).disabledColor,
                                    decoration: TextDecoration.lineThrough)
                                : TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.color,
                                  ),
                          ),
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<TasksBloc>(context),
                            child: TaskItem(task: task),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: BlocProvider.of<TasksBloc>(context),
                child: const TaskItem(task: Task()),
              ),
            ),
          );
        },
      ),
    );
  }

  void _deleteTask(BuildContext context, Task task) async {
    BlocProvider.of<TasksBloc>(context).add(DeleteTask(taskId: task.id!));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
        content: Text("Task deleted"),
      ),
    );
  }

  Future<bool> _confirmDismiss(
      BuildContext context, String taskDescription) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext inAlertContext) {
        return AlertDialog(
          title: const Text("Delete Task"),
          content: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: <TextSpan>[
                const TextSpan(text: 'Are you sure you want to delete "'),
                TextSpan(
                    text: taskDescription,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const TextSpan(text: '"?'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(inAlertContext).pop(false);
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () async {
                Navigator.of(inAlertContext).pop(true);
              },
            )
          ],
        );
      },
    );
  }
}
