import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_book/tasks/bloc/tasks_bloc.dart';
import 'package:flutter_book/tasks/task.dart';
import 'package:intl/intl.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  const TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  TaskItemState createState() => TaskItemState();
}

class TaskItemState extends State<TaskItem> {
  late final TextEditingController _descriptionEditingController;
  late final TextEditingController _dueDateEditingController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _descriptionEditingController =
        TextEditingController(text: widget.task.description);
    _dueDateEditingController =
        TextEditingController(text: widget.task.dueDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.description),
              title: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 8,
                decoration: const InputDecoration(hintText: "Description"),
                controller: _descriptionEditingController,
                validator: (String? inValue) {
                  if (inValue?.isEmpty == true) {
                    return "Please enter description";
                  }
                  return null;
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.today),
              title: TextFormField(
                decoration: InputDecoration(
                  hintText: "Due Date",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.blue,
                    onPressed: () async {
                      String selectedDate = await _selectDate(context);
                      _dueDateEditingController.text = selectedDate;
                    },
                  ),
                ),
                controller: _dueDateEditingController,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              label: const Text("Cancel"),
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Builder(
              builder: (context) => TextButton.icon(
                label: const Text("Save"),
                icon: const Icon(
                  Icons.save,
                  color: Colors.green,
                ),
                onPressed: () {
                  _save(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _save(BuildContext context) async {
    if (_formKey.currentState?.validate() == true) {
      if (widget.task.id == null) {
        BlocProvider.of<TasksBloc>(context).add(
          AddTask(
            task: Task(
              description: _descriptionEditingController.text,
              dueDate: _dueDateEditingController.text,
            ),
          ),
        );
      } else {
        BlocProvider.of<TasksBloc>(context).add(
          UpdateTask(
            task: widget.task.copyWith(
              description: _descriptionEditingController.text,
              dueDate: _dueDateEditingController.text,
            ),
          ),
        );
      }

      await ScaffoldMessenger.of(context)
          .showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
              content: Text("Task saved"),
            ),
          )
          .closed;
      // Navigator.of(context).pop();
    }
  }

  Future<String> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    initialDate = DateFormat.yMMMMd("en_US").parse(widget.task.dueDate!);
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    return DateFormat.yMMMMd("en_US").format(picked!.toLocal());
  }

  @override
  void dispose() {
    _descriptionEditingController.dispose();
    _dueDateEditingController.dispose();
    super.dispose();
  }
}
