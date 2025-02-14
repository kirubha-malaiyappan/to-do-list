import 'package:flutter/material.dart';
import 'package:practice_apps/Widgets/to_do_item.dart';
import 'package:practice_apps/Widgets/to_do_obj.dart';
import '../constants/app_styles.dart';


class HomePage extends StatefulWidget {
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  final todosList = ToDoObj.ListToDo();
  List<ToDoObj> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }
  
  void addVal(String task){
    setState(() {
      todosList.add(ToDoObj(id: DateTime.now().microsecondsSinceEpoch.toString(), text: task, isDone: false));
      _todoController.clear();
    });
  }

  void search(String task){
    setState(() {
      if (task.isEmpty) {
      _foundToDo = todosList; 
    } else {
      _foundToDo = todosList
          .where((todo) => todo.text.toLowerCase().contains(task.toLowerCase()))
          .toList();
    }
    });
  }
  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

   
 
  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      //AppBar
      appBar: AppBar(
        backgroundColor: AppStyles.bgColor,
        title:  Row(
          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Container(
              margin: const EdgeInsets.all(10),
              child: const Icon(Icons.menu, size: 33,)
              ),
            Container(
              margin:const  EdgeInsets.all(10),
              child: 
              const CircleAvatar(backgroundImage: AssetImage("assets/images/avatar.jpg"),minRadius: 25,)
              )
          ],
        ),
      ),
      body:   Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             _SearchBar1(),
            
            Expanded(child: ListView(
              children: [
                Container(
                            padding: const EdgeInsets.all(20),
                            
                            child: const Text(
                              'All ToDos',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          for (ToDoObj todoo in _foundToDo)
                       ToDoItem(
                           todo: todoo,
                            deleteCallback: _deleteToDoItem,  // Pass the delete function
                          ),                                      
              ],
            ),
            )
             
            ],
          ),
           Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 50 ,
                  width: size.width*0.8,
                      decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                          
                        ],
                        
                      ),
                      child: TextField(
                          controller : _todoController,
                         decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                 
                  hintText: "Add task ",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: InputBorder.none
            ),
                      ),
                ),
                FloatingActionButton(
                 
                  backgroundColor: AppStyles.buttonColor,
                  onPressed: (){
                      print("add");
                      addVal( _todoController.text);
                  },
                  child: const Icon(
                    Icons.add, 
                    color: Colors.white,),

                  )
              ],
            ),
            )
        ],
      ),
    );
  }


  Widget _SearchBar1(){
   
  return Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            //padding: EdgeInsets.all(10),
            
            height: 47,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child:  TextField(
              onTap: (){
                search(_searchController.text);

              },
              decoration: InputDecoration(
                  contentPadding: const  EdgeInsets.all(10),
                  prefixIcon: const Icon(Icons.search, color: Colors.black,),
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: InputBorder.none
            ),
            controller: _searchController,
           
          ), 
          );
}
}

