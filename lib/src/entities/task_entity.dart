class TaskEntity {
  final String id;
  final String? details;
  final String title;
  final DateTime startDate;
  final int durationMinutes;
  final int level;
  final String? location;
  final bool alert;
  final String repeatType;
  final String userId;

  TaskEntity(
      {required this.id,
      required this.title,
      required this.details,
      required this.startDate,
      required this.durationMinutes,
      required this.level,
      required this.location,
      required this.alert,
      required this.repeatType,
      required this.userId});

  factory TaskEntity.fromJson(Map<String, dynamic> json) {
    return TaskEntity(
      id: json['_id'],
      title: json['title'],
      details: json['details'],
      startDate: DateTime.parse(json['startDate']),
      durationMinutes: json['durationMinutes'],
      level: json['level'],
      location: json['location'],
      alert: json['alert'],
      repeatType: json['repeatType'],
      userId: json['userId'],
    );
  }
}
