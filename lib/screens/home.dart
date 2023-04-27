import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
final _todoController = TextEditingController();

@override
  void initState() {
  ///function to search the todos already in list
  _foundToDo = todosList;
    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 50,
                            bottom: 20,
                          ),
                          child: const Text(
                            'All ToDos',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        /// foundToDo.reversed ...the reversed added to show newly added todos see in first
                        for ( ToDo todoo in _foundToDo.reversed )
                          ToDoItem(
                            todo: todoo,
                              onToDoChanged: _handleToDoChange,
                            onDeleteItem: _deleteToDoItem,

                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:  TextField(
    controller: _todoController,
                      decoration: const InputDecoration(
                          hintText: 'Add a new todo item',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                     _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child:  const Text(
                      '+',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  ///function to select and unselect the todos
  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  ///function to delete the todos
  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }


  ///function to add a new todos
  void _addToDoItem(String todo){
    setState(() {
      ///by date_time milliseconds we add single todos at a time
      todosList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(),
          todotext: todo));
    });
    ///to clear the text - 'add a new todos item'
    _todoController.clear();
  }


  ///function to show in search box when we type to see the todos in the list already given and if not typed then show nothing
  void _runFilter(String enteredKeyword) {
  List<ToDo> results = [];
  if (enteredKeyword.isEmpty) {
    results = todosList;
  }else{
    results = todosList.where((item) => item.todotext!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
  }

  setState(() {
    _foundToDo = results;
  });
  }



///search function
  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child:  TextField(
        ///onChanged used to check every spelling in the todos list while typing same spells in the search
       onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }


  ///appbar function
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blueAccent,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(
          Icons.menu,
          color: Colors.black,
          size: 30,
        ),
        Column(
          children: const [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBcg5OV7m4Ojt-6P7o0JwzgBcZosZwisJw0A&usqp=CAU"),
            )
          ],
        )
      ]),
    );
  }
}
