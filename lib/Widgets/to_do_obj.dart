class ToDoObj {
  String id;
  String text;
  bool isDone;

  ToDoObj({required this.id, required this.text, this.isDone = false});

  factory ToDoObj.fromJson(Map<String, dynamic> json) {
    return ToDoObj(
      id: json['id'],
      text: json['text'],
      isDone: json['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isDone': isDone,
    };
  }

  static List<ToDoObj> ListToDo() {
    return [];
  }
}
