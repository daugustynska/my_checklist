import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../utilities/logic.dart';

class EditTaskScreen extends StatelessWidget {
  final Task taskToEdit;
  const EditTaskScreen({
    Key? key,
    required this.taskToEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: taskToEdit.title);
    TextEditingController descriptionController =
        TextEditingController(text: taskToEdit.description);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        const Text(
          'Edit task',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 10),
        TextField(
          autofocus: true,
          controller: titleController,
          maxLength: 40,
          decoration: const InputDecoration(
            label: Text('Title'),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          autofocus: true,
          controller: descriptionController,
          maxLength: 200,
          decoration: const InputDecoration(
            label: Text('Description'),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (isValidTitle(titleController.text)) {
                  var editedTask = Task(
                      title: titleController.text,
                      description: descriptionController.text,
                      id: taskToEdit.id,
                      isDone: false,
                      isDeleted: false);
                  context.read<TasksBloc>().add(
                      EditTask(taskToEdit: taskToEdit, editedTask: editedTask));
                  Navigator.pop(context);
                } else {
                  Flushbar(
                    flushbarPosition: FlushbarPosition.BOTTOM,
                    message:
                        "'Title' field must not be empty or consist of only spaces.",
                    duration: const Duration(seconds: 3),
                  ).show(context);
                }
              },
              child: const Text(
                'Save',
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
