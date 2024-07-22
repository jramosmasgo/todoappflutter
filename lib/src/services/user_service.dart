import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_friend/src/config/global_variables.dart';
import 'package:todo_friend/src/config/user_database.dart';
import 'package:todo_friend/src/entities/user_entity.dart';
import 'package:http/http.dart' as http;
import 'package:todo_friend/src/services/auth_firebase_service.dart';

class UserService {
  urlTask(String? params) =>
      Uri.https(GlobalVariables.apiUrl, "${GlobalVariables.user}$params");

  Future<UserEntity?> createUserApi(UserEntity user) async {
    int randomNumber = Random().nextInt(100);
    String defautImage =
        "https://res.cloudinary.com/musica-reservation/image/upload/v1721613552/userDefault_b5jodf.png";

    var response = await http.post(urlTask(""),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name":
              user.name == "" ? 'User ${randomNumber.toString()}' : user.name,
          "email": user.email,
          "firebaseId": user.firebaseId,
          "profileImage":
              user.profileImage == "" ? defautImage : user.profileImage,
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

  Future<UserEntity?> loginUserApi(String email, String firebaseId) async {
    var response = await http.put(urlTask("/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "firebaseId": firebaseId,
        }));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      var loginUser = UserEntity.fromJson(jsonMap['data']['userFounded']);
      await setUserLogged(loginUser);
      return loginUser;
    } else {
      return null;
    }
  }

  Future<UserEntity?> createUserFirebase(String email, String password) async {
    var result = await AuthFirebaseService()
        .createUserWithEmailAndPassword(email, password);

    if (result != null) {
      var newUserFromFirebase = UserEntity(
          id: "",
          name: result.displayName ?? "",
          email: result.email ?? "",
          firebaseId: result.uid,
          profileImage: result.photoURL ?? "",
          phone: result.phoneNumber ?? "");

      return await createUserApi(newUserFromFirebase);
    }

    return null;
  }

  Future<UserEntity?> loginUserFirebase(String email, String password) async {
    var result = await AuthFirebaseService()
        .loginUserWithEmailAndPassword(email, password);

    if (result != null) {
      return await loginUserApi(email, result.uid);
    }

    return null;
  }

  Future<UserEntity?> loginWithButtonGoogle(
      UserCredential resultLoginGoogle) async {
    // var resultLoginGoogle = await AuthFirebaseService().signInWithGoogle();

    if (resultLoginGoogle.user != null) {
      var responseFirstLogin = await http.put(urlTask("/login"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": resultLoginGoogle.user?.email,
            "firebaseId": resultLoginGoogle.user?.uid,
          }));

      if (responseFirstLogin.statusCode == 500) {
        Map<String, dynamic> jsonMap = json.decode(responseFirstLogin.body);
        if (jsonMap['message'] == "User not founded") {
          var newUser = UserEntity(
              id: "",
              name: resultLoginGoogle.user?.displayName ?? "",
              email: resultLoginGoogle.user?.email ?? "",
              firebaseId: resultLoginGoogle.user?.uid ?? "",
              profileImage: resultLoginGoogle.user?.photoURL ?? "",
              phone: resultLoginGoogle.user?.phoneNumber ?? "");
          return createUserApi(newUser);
        } else {
          Map<String, dynamic> jsonMap = json.decode(responseFirstLogin.body);
          var loginUser = UserEntity.fromJson(jsonMap['data']['userFounded']);
          await setUserLogged(loginUser);
          return loginUser;
        }
      }
    }
    return null;
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
