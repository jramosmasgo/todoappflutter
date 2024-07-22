import 'dart:convert';
import 'dart:math';

import 'package:todo_friend/src/config/user_database.dart';
import 'package:todo_friend/src/entities/user_entity.dart';
import 'package:http/http.dart' as http;
import 'package:todo_friend/src/services/auth_firebase_service.dart';

class UserService {
  Future<UserEntity?> createUser(String email, String password) async {
    var result = await AuthFirebaseService()
        .createUserWithEmailAndPassword(email, password);

    Random random = Random();
    int randomNumber = random.nextInt(100);

    var url = Uri.https('my-todoapp-friend.onrender.com', '/api/user');

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": 'User ${randomNumber.toString()}',
          "email": email,
          "firebaseId": result?.uid,
          "profileImage":
              'https://cdn-icons-png.freepik.com/512/9453/9453886.png',
          "phone": ''
        }));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      var registeredUser = UserEntity.fromJson(jsonMap['data']);
      await setUserLogged(registeredUser);
      return registeredUser;
    } else {
      return null;
    }
  }

  Future<UserEntity?> loginUser(String email, String firebaseId) async {
    var url = Uri.https('my-todoapp-friend.onrender.com', '/api/user/login');

    var response = await http.put(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "firebaseId": firebaseId,
        }));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      return UserEntity.fromJson(jsonMap['data']['userFounded']);
    } else {
      return null;
    }
  }

  Future<UserEntity?> loginUserGoogle(String email, String password) async {
    var url = Uri.https('my-todoapp-friend.onrender.com', '/api/user/login');

    var result = await AuthFirebaseService()
        .loginUserWithEmailAndPassword(email, password);

    if (result != null) {
      var response = await http.put(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": email,
            "firebaseId": result.uid,
          }));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        var registeredUser =
            UserEntity.fromJson(jsonMap['data']['userFounded']);
        await setUserLogged(registeredUser);
        return registeredUser;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<UserEntity?> loginWithButtonGoogle() async {
    var url = Uri.https('my-todoapp-friend.onrender.com', '/api/user/login');

    var result = await AuthFirebaseService().signInWithGoogle();

    if (result.user != null) {
      var response = await http.put(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": result.user?.email,
            "firebaseId": result.user?.uid,
          }));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        var registeredUser =
            UserEntity.fromJson(jsonMap['data']['userFounded']);
        await setUserLogged(registeredUser);
        return registeredUser;
      } else {
        var url2 = Uri.https('my-todoapp-friend.onrender.com', '/api/user');
        Random random = Random();
        int randomNumber = random.nextInt(100);

        var responseCreation = await http.post(url2,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "name": 'User ${randomNumber.toString()}',
              "email": result.user?.email,
              "firebaseId": result.user?.uid,
              "profileImage":
                  'https://cdn-icons-png.freepik.com/512/9453/9453886.png',
              "phone": ''
            }));

        if (responseCreation.statusCode == 200) {
          Map<String, dynamic> jsonMap2 = json.decode(responseCreation.body);
          var registeredUser = UserEntity.fromJson(jsonMap2['data']);
          await setUserLogged(registeredUser);
        } else {
          return null;
        }

        return null;
      }
    } else {
      return null;
    }
  }

  Future<void> setUserLogged(UserEntity user) async {
    UserDatabase registeredUser = UserDatabase(
        userId: user.id,
        email: user.email,
        name: user.name,
        profileImage: user.profileImage,
        phone: user.profileImage,
        firebaseId: user.firebaseId,
        token: '');
    UserHelper userHelper = UserHelper();
    await userHelper.insertUser(registeredUser);
  }
}
