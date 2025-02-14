class ToDoObj{
    final String id;
    final String text;
    bool isDone;
    ToDoObj(
      { 
        required this.id,
        required this.text,
        required this.isDone,
        }
      );
       static List<ToDoObj> ListToDo(){
            return <ToDoObj>[
        ToDoObj(id: "1", text: "do laundry", isDone: true),
        ToDoObj(id: "2", text: "write assignments", isDone: true),
        ToDoObj(id: "3", text: "cook pasta", isDone: false),
        ToDoObj(id: "4", text: "code app", isDone: false),

    ];
}
}

