class Task {
  final int? id;
  final String name;
  final String description;
  final DateTime dueTime;
  final bool notification;
  final String status;
  final bool isTrashed;

  Task({
    this.id,
    required this.name,
    required this.description,
    required this.dueTime,
    required this.notification,
    required this.status,
    required this.isTrashed,
  });

  // Clone the current object with new properties
  Task clone({
    int? id,
    String? name,
    String? description,
    DateTime? dueTime,
    bool? notification,
    String? status,
    bool? isTrashed,
  }) =>
      Task(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        dueTime: dueTime ?? this.dueTime,
        notification: notification ?? this.notification,
        status: status ?? this.status,
        isTrashed: isTrashed ?? this.isTrashed,
      );

  Map<String, Object?> toJson() => {
        'ID': id,
        'NAME': name,
        'DESCRIPTION': description,
        'DUETIME': dueTime.toIso8601String(),
        'STATUS': status,
        'IS_TRASHED': isTrashed ? 1 : 0,
      };

  static Task fromJson(Map<String, Object?> json) => Task(
        id: json['ID'] as int,
        name: json['NAME'] as String,
        description: json['DESCRIPTION'] as String,
        dueTime: DateTime.parse(json['DUETIME'] as String),
        notification: json['NOTIFICATION'] == 1,
        status: json['STATUS'] as String,
        isTrashed: json['IS_TRASHED'] == 1,
      );
}
