import 'package:flutter/cupertino.dart';
import 'package:todo_friend/src/entities/task_entity.dart';
import 'package:todo_friend/src/entities/user_entity.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskEntity> tasks = [];
  List<TaskEntity> tasksFiltered = [];
  UserEntity? userlogued;
  DateTime selectedDate = DateTime.now();
  bool darkTheme = false;

  resetStatus() {
    tasks = [];
    tasksFiltered = [];
    userlogued = null;
    selectedDate = DateTime.now();
    darkTheme = false;
  }

  setDarkMode(bool enabled) {
    darkTheme = enabled;
    notifyListeners();
  }

  addTask(TaskEntity newTask) {
    tasks.add(newTask);
    notifyListeners();
  }

  updateListTask(TaskEntity task) {
    var index = tasks.indexWhere((x) => x.id == task.id);
    if (index >= 0) {
      tasks[index] = task;
      filterTasksByDate(selectedDate);
    }
  }

  deleteTask(TaskEntity task) {
    var index = tasks.indexWhere((x) => x.id == task.id);
    if (index >= 0) {
      tasks.removeAt(index);
      filterTasksByDate(selectedDate);
    }
  }

  addListTask(List<TaskEntity> newTask) {
    tasks = newTask;
    notifyListeners();
  }

  addUser(UserEntity user) {
    userlogued = user;
    notifyListeners();
  }

  filterTasksByDate(DateTime daySelected) {
    var dayEntry =
        DateTime(daySelected.year, daySelected.month, daySelected.day);

    if (tasks.isEmpty) return tasksFiltered = [];

    var onceTaks = tasks
        .where((x) =>
            x.repeatType == "once" &&
            DateTime(x.startDate.year, x.startDate.month, x.startDate.day) ==
                dayEntry)
        .toList();

    var repeatEveryDay = tasks
        .where((x) =>
            x.repeatType == "diary" &&
            (dayEntry.isAfter(DateTime(
                    x.startDate.year, x.startDate.month, x.startDate.day)) ||
                dayEntry.isAtSameMomentAs(DateTime(
                    x.startDate.year, x.startDate.month, x.startDate.day))))
        .toList();

    var repearWeekly = tasks
        .where((x) =>
            x.repeatType == "weekly" && x.startDate.weekday == dayEntry.weekday)
        .toList();

    List<TaskEntity> allList =
        {...onceTaks, ...repeatEveryDay, ...repearWeekly}.toList();
    allList.sort((a, b) => a.startDate.compareTo(b.startDate));
    tasksFiltered = allList;

    notifyListeners();
  }
}
