import 'package:flutter/material.dart';
import 'package:my_checklist/pages/calendar_screen.dart';
import 'package:my_checklist/widgets/progress_bar.dart';
import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../widgets/tasks_list.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const AddTaskScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.allTasks;
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Checklist'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Divider(height: 3, thickness: 3, color: Colors.grey.shade300),
              Row(children: [
                Container(
                    alignment: Alignment.centerRight,
                    height: 40,
                    width: 100,
                    decoration: const BoxDecoration(color: Colors.blue),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      color: Colors.white,
                      iconSize: 20,
                      tooltip: 'Yesterday',
                      onPressed: () {},
                    )),
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: MediaQuery.of(context).size.width - 200,
                  decoration: const BoxDecoration(color: Colors.blue),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CalendarScreen()),
                        );
                      },
                      child: Text(
                        DateTime.now().toString().split(" ")[0],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    width: 100,
                    decoration: const BoxDecoration(color: Colors.blue),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                      color: Colors.white,
                      iconSize: 20,
                      tooltip: 'Tomorrow',
                      onPressed: () {},
                    )),
              ]),
              Divider(height: 3, thickness: 3, color: Colors.grey.shade300),
              ProgressBar(
                completed: state.completedTasks,
                all: state.allTasks,
              ),
              Divider(height: 3, thickness: 3, color: Colors.grey.shade300),
              TasksList(
                tasksList: tasksList,
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addTask(context),
            tooltip: 'Add Task',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
