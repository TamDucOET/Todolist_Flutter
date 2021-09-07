final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [id, isComplete, title, description, time];

  static final String id = '_id';
  static final String isComplete = 'isComplete';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
}

class Note {
  final int? id;
  final bool isComplete;
  final String title;
  final String description;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.isComplete,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Note copy({
    int? id,
    bool? isComplete,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        isComplete: isComplete ?? this.isComplete,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        isComplete: json[NoteFields.isComplete] == 1,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.isComplete: isComplete ? 1 : 0,
        NoteFields.description: description,
        NoteFields.time: createdTime.toIso8601String(),
      };
}
