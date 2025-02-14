import 'package:flutter/material.dart';
import 'package:practice_apps/Widgets/to_do_obj.dart';

import '../constants/app_styles.dart';

class ToDoItem extends StatefulWidget {
  final ToDoObj todo;
  const ToDoItem({super.key, required this.todo});

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
   var toDoList = ToDoObj.ListToDo();
 
 void _onClicked(){
  
  setState(() {
    widget.todo.isDone = !widget.todo.isDone;
  });
 }




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onClicked();
        
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
        child: ListTile(
          leading: Icon(
            widget.todo.isDone ?Icons.check_box_rounded : Icons.check_box_outline_blank,
             color: AppStyles.buttonColor,
             ),
          title:  Text(
            widget.todo.text ,
             style:  TextStyle(
                fontWeight: FontWeight.w500,
                decoration: widget.todo.isDone ? TextDecoration.lineThrough : null,
             ),
            ),
          trailing: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(7)
            ),
            child: Center(
              child: IconButton(
                 padding: EdgeInsets.zero, 
                 constraints: BoxConstraints(), 
                onPressed:
                 (){
                  print("deleting ${widget.todo.id}");
                  
                 }, 
                 icon: const Icon(
                  Icons.delete,
                   color: AppStyles.buttonColor,
                    size: 25,
                    )
                    ),
            ),
          ),
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          
          
        ),
      ),
    );
  }
}
