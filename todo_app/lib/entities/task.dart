class Task {
  final String name;
  final String description;
  final DateTime dueTime;
  final String status;
  final bool isTrashed;

  Task(this.name, this.description, this.dueTime, this.status, this.isTrashed);
}