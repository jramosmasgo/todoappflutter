import 'dart:convert';

import 'package:todo_friend/src/entities/user_entity.dart';
import 'package:http/http.dart' as http;
import 'package:todo_friend/src/services/auth_firebase_service.dart';

class UserService {
  Future<UserEntity?> createUser(String email, String password) async {
    var result = await AuthFirebaseService()
        .createUserWithEmailAndPassword(email, password);

    var url = Uri.https('my-todoapp-friend.onrender.com', '/api/user');

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          {
            "name": 'User',
            "email": email,
            "firebaseId": result?.uid,
            "profileImage":
                'https://cdn-icons-png.freepik.com/512/9453/9453886.png',
            "phone": ''
          }
        }));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      return UserEntity.fromJson(jsonMap['data']);
    } else {
      return null;
    }
  }

  Future<UserEntity?> loginUser(String email, String password) async {
    var url = Uri.https('my-todoapp-friend.onrender.com', '/api/user/login');

    var result = await AuthFirebaseService()
        .loginUserWithEmailAndPassword(email, password);

    var response = await http.put(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          {
            "email": email,
            "firebaseId": result?.uid,
          }
        }));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      return UserEntity.fromJson(jsonMap['data']);
    } else {
      return null;
    }
  }
}
