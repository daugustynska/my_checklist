import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:my_checklist/blocs/bloc_exports.dart';
import 'package:my_checklist/models/task.dart';

Flushbar<dynamic> deleteTaskFlushbar(BuildContext context, Task task) {
  return Flushbar(
    flushbarPosition: FlushbarPosition.BOTTOM,
    padding: const EdgeInsets.only(left: 25, right: 30, top: 20, bottom: 20),
    message: "Delete this task?",
    mainButton: OutlinedButton(
      style: const ButtonStyle(
          foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
          backgroundColor: MaterialStatePropertyAll<Color>(Colors.red)),
      onPressed: () {
        context.read<TasksBloc>().add(DeleteTask(task: task));
      },
      child: const Text("Confirm"),
    ),
    duration: const Duration(seconds: 2),
  );
}
