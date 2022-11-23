import 'package:equatable/equatable.dart';
import '../../models/task.dart';
import '../bloc_exports.dart';
part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<EditTask>(_onEditTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(TasksState(
      completedTasks: state.completedTasks,
      allTasks: List.from(state.allTasks)..add(event.task),
    ));
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.taskToEdit;
    final int index = state.allTasks.indexOf(task);

    List<Task> completedTasks = List.from(state.completedTasks)..remove(task);
    List<Task> allTasks = List.from(state.allTasks)
      ..remove(task)
      ..insert(index, event.editedTask);

    task.isDone == true ? completedTasks.remove(task) : completedTasks;

    emit(TasksState(
      completedTasks: completedTasks,
      allTasks: allTasks,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    final int index = state.allTasks.indexOf(task);

    List<Task> completedTasks = List.from(state.completedTasks)..remove(task);
    List<Task> allTasks = List.from(state.allTasks)..remove(task);

    task.isDone == false
        ? {
            completedTasks.insert(0, task.copyWith(isDone: true)),
            allTasks.insert(index, task.copyWith(isDone: true)),
          }
        : {
            completedTasks.remove(task),
            allTasks.insert(index, task.copyWith(isDone: false)),
          };

    emit(TasksState(completedTasks: completedTasks, allTasks: allTasks));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> completedTasks = List.from(state.completedTasks);
    List<Task> allTasks = List.from(state.allTasks)..remove(event.task);

    task.isDone == true ? completedTasks.remove(task) : completedTasks;

    emit(TasksState(
      completedTasks: completedTasks,
      allTasks: allTasks,
    ));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
