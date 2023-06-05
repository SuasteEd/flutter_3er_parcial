class Note {
  String? id;
  String createdAt;
  String idUser;
  String idTag;
  String title;
  String description;
  String date;

  Note({
    this.id,
    required this.createdAt,
    required this.idUser,
    required this.idTag,
    required this.title,
    required this.description,
    required this.date,
  });
}
