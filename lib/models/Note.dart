class Note {
  final int id;
  final String title;
  final String content;
  final int status;
  final String created_at;
  final String updated_at;

  Note(
      {required this.id,
      required this.title,
      required this.content,
      required this.status,
      required this.created_at,
      required this.updated_at});
}
