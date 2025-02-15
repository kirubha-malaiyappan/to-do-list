import 'package:flutter/material.dart';
import 'package:practice_apps/Widgets/to_do_item.dart';
import 'package:practice_apps/Widgets/to_do_obj.dart';
import '../constants/app_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late  SharedPreferences pref;
  final _searchController = TextEditingController();
  final todosList = ToDoObj.ListToDo();
  List<ToDoObj> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    initPreferences();
    super.initState();
  }

  void initPreferences() async{
    pref = await SharedPreferences.getInstance();
  }
  
  void addVal(String task) {
    if (task.isNotEmpty) {
      setState(() {
        todosList.add(ToDoObj(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          text: task,
          isDone: false,
        ));
        _todoController.clear();
      });
    }
  }

  void search(String task) {
    setState(() {
      _foundToDo = task.isEmpty
          ? todosList
          : todosList.where((todo) => todo.text.toLowerCase().contains(task.toLowerCase())).toList();
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
      appBar: AppBar(
        backgroundColor: AppStyles.bgColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.menu, size: 33),
              onPressed: () {},
            ),
            const CircleAvatar(
              backgroundImage: AssetImage("assets/images/avatar.jpg"),
              minRadius: 25,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _searchBar(),
              Expanded(
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(
                        'All ToDos',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ),
                    for (ToDoObj todo in _foundToDo)
                      ToDoItem(
                        todo: todo,
                        deleteCallback: _deleteToDoItem,
                      ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _todoController,
                        decoration: InputDecoration(
                          hintText: "Add task",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    backgroundColor: AppStyles.buttonColor,
                    onPressed: () => addVal(_todoController.text),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      height: 47,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: search,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: const Icon(Icons.search, color: Colors.black),
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
