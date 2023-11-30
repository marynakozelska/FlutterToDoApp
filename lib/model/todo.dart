class ToDo {
  String? id;
  String? toDoText;
  bool isDone;
  String? category;

  ToDo({
    required this.id,
    required this.toDoText,
    this.isDone = false,
    this.category,
  });

  ToDo copyWith({
    String? id,
    String? toDoText,
    bool? isDone,
    String? category,
  }) {
    return ToDo(
      id: id ?? this.id,
      toDoText: toDoText ?? this.toDoText,
      isDone: isDone ?? this.isDone,
      category: category ?? this.category,
    );
  }

  static List<ToDo> todoList() {
    return [
      ToDo(
        id: '1',
        toDoText: 'Morning Exercise',
        isDone: true,
        category: 'Health',
      ),
      ToDo(
        id: '2',
        toDoText: 'Team Meeting',
        category: 'Work',
      ),
    ];
  }
}
