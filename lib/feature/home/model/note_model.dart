class NoteModel {
  String title;
  String content;
  String color;
  bool isSynced;

  NoteModel({
    required this.title,
    required this.content,
    required this.color,
    this.isSynced = false,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    title: json['title'],
    content: json['content'],
    color: json['color'],
    isSynced: json['isSynced'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'content': content,
    'color': color,
    'isSynced': isSynced,
  };
}
