import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_friend/src/entities/task_entity.dart';

class TaskService {
  Future<bool> sendDataTask(TaskEntity task) async {
    var url = Uri.https('my-todoapp-friend.onrender.com', '/api/task');

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": "668c18d01d4fe08e2324dbae",
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
      return true;
    } else {
      return false;
    }
  }

  Future<List<TaskEntity>> getTasks() async {
    var url = Uri.https('my-todoapp-friend.onrender.com',
        '/api/task/user/668c18d01d4fe08e2324dbae');

    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    List<TaskEntity> tasks = parseTasks(response.body);
    return tasks;
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
