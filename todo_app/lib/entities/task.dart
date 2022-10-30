class Task {
  final int id;
  final String name;
  final String description;
  final DateTime dueTime;
  final String status;
  final bool isTrashed;
  final DateTime trashedTime;

  Task(
    this.id,
    this.name,
    this.description,
    this.dueTime,
    this.status,
    this.isTrashed,
    this.trashedTime,
  );

  Map<String, Object?> toJson() => {
        'ID': id,
        'NAME': name,
        'DESCRIPTION': description,
        'DUETIME': dueTime.toIso8601String(),
        'STATUS': status,
        '': isTrashed ? 1 : 0,
        'TRASHED_TIME': trashedTime.toIso8601String()
      };

  static Task fromJson(Map<String, Object?> json) => Task(
        json['ID'] as int,
        json['NAME'] as String,
        json['DESCRIPTION'] as String,
        json['DUETIME'] as DateTime,
        json['STATUS'] as String,
        json['IS_TRASHED'] == 1,
        json['TRASHED_TIME'] as DateTime,
      );
}
