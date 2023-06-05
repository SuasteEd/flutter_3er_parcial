class TaskModel {
  String? id;
  String createdAt;
  //String finichedAt;
  String idUser;
  String tag;
  String title;
  String description;
  String date;
  bool isCompleted;
  int priority;

  TaskModel({
    this.id,
    required this.createdAt,
    required this.idUser,
    required this.tag,
    required this.title,
    required this.description,
    required this.date,
    required this.isCompleted,
    required this.priority,
  });
}
