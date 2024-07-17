import 'package:flutter/cupertino.dart';
import 'package:todo_friend/src/entities/task_entity.dart';
import 'package:todo_friend/src/entities/user_entity.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskEntity> tasks = [];
  late UserEntity userlogued;

  addTask(TaskEntity newTask) {
    tasks.add(newTask);
    notifyListeners();
  }

  addListTask(List<TaskEntity> newTask) {
    tasks = newTask;
    notifyListeners();
  }

  addUser(UserEntity user) {
    userlogued = user;
    notifyListeners();
  }
}
