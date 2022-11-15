import 'package:flutter/material.dart';
import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../services/guid_gen.dart';
import 'package:another_flushbar/flushbar.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        const Text(
          'Add a new task',
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 10),
        TextField(
          autofocus: true,
          controller: titleController,
          decoration: const InputDecoration(
            label: Text('Title'),
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
                  var task =
                      Task(title: titleController.text, id: GUIDGen.generate());
                  context.read<TasksBloc>().add(AddTask(task: task));
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
                'Add',
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

bool isValidTitle(String string) {
  String newString = string.replaceAll(' ', '');
  if (newString.isEmpty) {
    return false;
  } else {
    return true;
  }
}
