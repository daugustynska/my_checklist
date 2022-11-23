part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> allTasks;
  final List<Task> completedTasks;
  const TasksState({
    this.completedTasks = const <Task>[],
    this.allTasks = const <Task>[],
  });

  @override
  List<Object> get props => [completedTasks, allTasks];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'completedTasks': allTasks.map((x) => x.toMap()).toList(),
      'allTasks': allTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      completedTasks: List<Task>.from(
        map['completedTasks']?.map((x) => Task.fromMap(x)),
      ),
      allTasks: List<Task>.from(
        map['allTasks']?.map((x) => Task.fromMap(x)),
      ),
    );
  }
}
