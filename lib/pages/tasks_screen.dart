import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
              //calendar here
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 70,
                animation: true,
                animationDuration: 1500,
                lineHeight: 23,
                progressColor: Colors.blue,
                backgroundColor: Colors.grey.shade300,
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                leading: Container(
                    width: 70,
                    height: 23,
                    decoration: const BoxDecoration(color: Colors.blue),
                    child: const Center(
                      child: Text(
                        "Progress:",
                        textAlign: TextAlign.center,
                      ),
                    )),
                percent: state.completedTasks.length / state.allTasks.length,
                center: Text(
                    "${(state.completedTasks.length / state.allTasks.length * 100).toStringAsFixed(0)} %"),
              ),
              TasksList(tasksList: tasksList)
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
