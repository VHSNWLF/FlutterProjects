import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/todo.dart';

const todoListKey = "todo_list";

class TodoRepository  {
  
  late SharedPreferences sharedPreferences;

  Future<List<Todo>> getTodoList() async{
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(todoListKey) ?? '[]'; //se não encontrar nada ele retonra uma lista vazia no formato json (caso da primeira vez usando o app, ou se nn tiver nenhum item na lista)
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Todo.fromJson(e)).toList();
  }

  void saveTodoList(List<Todo> todos){
    final String formatJson = json.encode(todos);
    sharedPreferences.setString(todoListKey, formatJson);
  }

}