import 'package:flutter/material.dart';

class ToDo extends StatelessWidget{
  String? id;
  String? todotext;
  bool isDone;

  ToDo({
    required this.id,
    required this.todotext,
    this.isDone = false,
});

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todotext: 'Morning Exercise', isDone: true),
      ToDo(id: '02', todotext: 'Buy Groceries', isDone: true),
      ToDo(id: '03', todotext: 'Check Emails', ),
      ToDo(id: '04', todotext: 'Team Meeting', ),
      ToDo(id: '05', todotext: 'Work on coding for 3 hour', ),
      ToDo(id: '06', todotext: 'Dinner with Jane', ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}