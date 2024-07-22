import 'package:todo_friend/src/config/database_helper.dart';

class UserDatabase {
  int? id;
  String userId;
  String name;
  String email;
  String profileImage;
  String phone;
  String firebaseId;
  String token;

  UserDatabase(
      {this.id,
      required this.userId,
      required this.name,
      required this.email,
      required this.profileImage,
      required this.phone,
      required this.firebaseId,
      required this.token});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'phone': phone,
      'firebaseId': firebaseId,
      'token': token,
    };
  }
}

class UserHelper {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertUser(UserDatabase user) async {
    final db = await _databaseHelper.database;
    return await db.insert('userLogged', user.toMap());
  }

  Future<void> removeTableUser() async {
    final db = await _databaseHelper.database;
    await db.execute("DROP TABLE IF EXISTS userLogged");
  }

  Future<UserDatabase?> getUserLogged() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'userLogged',
      orderBy: 'id ASC',
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return UserDatabase(
        id: maps.first['id'],
        userId: maps.first['userId'],
        name: maps.first['name'],
        email: maps.first['email'],
        profileImage: maps.first['profileImage'],
        phone: maps.first['phone'],
        firebaseId: maps.first['firebaseId'],
        token: maps.first['token'],
      );
    } else {
      return null;
    }
  }

  Future<int> deleteUser(String idUser) async {
    final db = await _databaseHelper.database;
    return await db.delete(
      'userLogged',
    );
  }
}
