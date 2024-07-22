import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_friend/src/config/global_variables.dart';
import 'package:todo_friend/src/entities/task_entity.dart';

class TaskService {
  urlTask(String? params) =>
      Uri.https(GlobalVariables.apiUrl, "${GlobalVariables.taks}$params");

  Future<TaskEntity?> sendDataTask(TaskEntity task) async {
    var response = await http.post(urlTask(''),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": task.userId,
          "title": task.title,
          "details": task.details,
          "startDate": task.startDate.toIso8601String(),
          "durationMinutes": task.durationMinutes,
          "level": task.level,
          "location": task.location,
          "alert": task.alert,
          "active": true,
          "repeatType": task.repeatType,
          "repeatWeekDays": "",
          "alertVoice": true,
          "readDetails": false
        }));

    if (response.statusCode == 200) {
      return parseTaskEntity(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<TaskEntity?> updateDataTask(TaskEntity task) async {
    var response = await http.put(urlTask('/${task.id}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": task.userId,
          "title": task.title,
          "details": task.details,
          "startDate": task.startDate.toIso8601String(),
          "durationMinutes": task.durationMinutes,
          "level": task.level,
          "location": task.location,
          "alert": task.alert,
          "active": true,
          "repeatType": task.repeatType,
          "repeatWeekDays": "",
          "alertVoice": true,
          "readDetails": false
        }));

    if (response.statusCode == 200) {
      return parseTaskEntity(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<TaskEntity?> deleteTask(TaskEntity task) async {
    var response = await http.put(urlTask('/${task.id}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": task.userId,
          "title": task.title,
          "details": task.details,
          "startDate": task.startDate.toIso8601String(),
          "durationMinutes": task.durationMinutes,
          "level": task.level,
          "location": task.location,
          "alert": task.alert,
          "active": false,
          "repeatType": task.repeatType,
          "repeatWeekDays": "",
          "alertVoice": true,
          "readDetails": false
        }));

    if (response.statusCode == 200) {
      return parseTaskEntity(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<List<TaskEntity>> getTasks(String idUser) async {
    var response = await http.get(urlTask("/user/$idUser"),
        headers: {"Content-Type": "application/json"});

    List<TaskEntity> tasks = parseTasks(response.body);
    return tasks;
  }

  Future<List<TaskEntity>> getTasksByDate(DateTime fecha, String idUser) async {
    var response = await http.put(urlTask("/user/tasks/$idUser"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"date": fecha}));

    List<TaskEntity> tasks = parseTasks(response.body);
    return tasks;
  }

  TaskEntity parseTaskEntity(Map<String, dynamic> json) {
    var data = json['data'];
    return TaskEntity(
      id: data['_id'],
      title: data['title'],
      details: data['details'],
      startDate: DateTime.parse(data['startDate']),
      durationMinutes: data['durationMinutes'],
      level: data['level'],
      location: '', // Asignar valor predeterminado a location
      alert: data['alert'],
      repeatType: data['repeatType'],
      userId: data['userId'],
    );
  }

  List<TaskEntity> parseTasks(String responseBody) {
    final parsed = jsonDecode(responseBody);
    if (parsed['ok'] == true && parsed['data'] is List) {
      return (parsed['data'] as List)
          .map<TaskEntity>((json) => TaskEntity.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to parse tasks');
    }
  }
}
