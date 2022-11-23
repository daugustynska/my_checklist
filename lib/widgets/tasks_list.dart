import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:my_checklist/blocs/bloc_exports.dart';
import '../models/task.dart';
import '../pages/edit_task_screen.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    Key? key,
    required this.tasksList,
  }) : super(key: key);

  final List<Task> tasksList;

  void _editTask(BuildContext context, task) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: EditTaskScreen(
            taskToEdit: task,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: tasksList.length,
          itemBuilder: (context, index) {
            var task = tasksList[index];
            return ListTile(
                title: Text(task.title),
                subtitle: task.description.isNotEmpty
                    ? Text(task.description)
                    : const Text('(no description)'),
                minVerticalPadding: 10,
                leading: Checkbox(
                  value: task.isDone,
                  onChanged: (value) {
                    context.read<TasksBloc>().add(UpdateTask(task: task));
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  splashRadius: 20.0,
                  tooltip: "Edit Task",
                  onPressed: (() => _editTask(context, task)),
                ),
                onLongPress: (() => Flushbar(
                      flushbarPosition: FlushbarPosition.BOTTOM,
                      padding: const EdgeInsets.only(
                          left: 25, right: 30, top: 20, bottom: 20),
                      message: "Delete this task?",
                      mainButton: OutlinedButton(
                        style: const ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll<Color>(Colors.white),
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.red)),
                        onPressed: () {
                          context.read<TasksBloc>().add(DeleteTask(task: task));
                        },
                        child: const Text("Confirm"),
                      ),
                      duration: const Duration(seconds: 2),
                    ).show(context)));
          }),
    );
  }
}
