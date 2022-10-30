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
    'IS_TRASHED': isTrashed ? 1 : 0,
    'TRASHED_TIME': trashedTime.toIso8601String()
  };
}
