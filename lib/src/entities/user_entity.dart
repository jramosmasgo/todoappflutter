class UserEntity {
  String id;
  String name;
  String email;
  String firebaseId;
  String profileImage;
  String phone;

  UserEntity(
      {required this.id,
      required this.name,
      required this.email,
      required this.firebaseId,
      required this.profileImage,
      required this.phone});

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      firebaseId: json['firebaseId'],
      profileImage: json['profileImage'],
      phone: json['phone'],
    );
  }
}
