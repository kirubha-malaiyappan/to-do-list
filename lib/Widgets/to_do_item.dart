import 'package:flutter/material.dart';
import 'package:practice_apps/Widgets/to_do_obj.dart';

import '../constants/app_styles.dart';

class ToDoItem extends StatefulWidget {
  final ToDoObj todo;
   final Function(String) deleteCallback; 
 
  const ToDoItem({super.key, required this.todo, required this.deleteCallback });

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
   //var toDoList = ToDoObj.ListToDo();
   
 
 void _onClicked(){
  
  setState(() {
    widget.todo.isDone = !widget.todo.isDone;
  });
 }

void delete(String id) {
  widget.deleteCallback(id); 
}



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onClicked();
        
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
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
                 constraints: const BoxConstraints(), 
                onPressed:
                 (){
                  print("deleting ${widget.todo.id}");
                  delete(widget.todo.id);
                  
                  
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
