import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_book/tasks/bloc/tasks_bloc.dart';
import 'package:flutter_book/tasks/model/task.dart';
import 'package:intl/intl.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  TaskItem({Key key, this.task}) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  TextEditingController _descriptionEditingController;
  TextEditingController _dueDateEditingController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _descriptionEditingController = TextEditingController(text: widget.task.description);
    _dueDateEditingController = TextEditingController(text: widget.task.dueDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.description),
              title: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 8,
                decoration: InputDecoration(hintText: "Description"),
                controller: _descriptionEditingController,
                validator: (String inValue) {
                  if (inValue.length == 0) {
                    return "Please enter description";
                  }
                  return null;
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.today),
              title: TextFormField(
                decoration: InputDecoration(
                  hintText: "Due Date",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.blue,
                    onPressed: () async {
                      String selectedDate = await selectDate(context);
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
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlatButton.icon(
              label: Text("Cancel"),
              icon: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Builder(
              builder: (context) => FlatButton.icon(
                label: Text("Save"),
                icon: Icon(
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
    if (_formKey.currentState.validate()) {
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
            task: Task(
              id: widget.task.id,
              description: _descriptionEditingController.text,
              dueDate: _dueDateEditingController.text,
            ),
          ),
        );
      }

      await Scaffold.of(context)
          .showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
              content: Text("Task saved"),
            ),
          )
          .closed;
      Navigator.of(context).pop();
    }
  }

  Future<String> selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    if (widget.task.dueDate != null) {
      initialDate = DateFormat.yMMMMd("en_US").parse(widget.task.dueDate);
    }
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null) {
      return DateFormat.yMMMMd("en_US").format(picked.toLocal());
    }
    return null;
  }
}
