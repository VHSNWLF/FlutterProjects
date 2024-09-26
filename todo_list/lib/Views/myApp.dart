// ignore_for_file: prefer_const_constructors, file_names, sort_child_properties_last, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:todo_list/Repositories/todo_repository.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/widgets/toDoListItem.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoPos;
  final TextEditingController todoController = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();

  @override
  void initState() {
    super.initState();

    todoRepository.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  void _showMessageError() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Erro ao adicionar tarefa"),
        content: Text(
            "Tarefa sem nome. Por favor dê um nome a sua tarefa e tente novamente."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: Color(0xff00d6f3),
                        controller: todoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff00d6f3), width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff00d6f3),
                              width: 2,
                            ),
                          ),
                          labelText: "Adicione uma tarefa",
                          labelStyle: TextStyle(
                            color: Color(0xff00d6f3),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        todoController.text != ''
                            ? setState(() {
                                Todo newTodo = Todo(
                                    title: todoController.text,
                                    dateTime: DateTime.now());
                                todos.add(newTodo);
                                todoController.clear();
                              })
                            : _showMessageError();
                        todoRepository.saveTodoList(todos);
                      },
                      child: Icon(Icons.add, size: 30, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(14),
                        backgroundColor: Color(0xff00d6f3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        ToDoListItem(
                          todo: todo,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                            "Você possui ${todos.length} tarefas pendentes")),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: showDeleteTodosConfirmationDialog,
                      child: Text(
                        "Limpar tudo",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(14),
                        backgroundColor: Color(0xff00d6f3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });
    todoRepository.saveTodoList(todos);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Tarefa ${todo.title} excluída com sucesso!",
          style: TextStyle(
            color: Color(0xff060708),
          ),
        ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: "Desfazer",
          textColor: Color(0xff00d7f3),
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPos!, deletedTodo!);
            });
            todoRepository.saveTodoList(todos);
          },
        ),
        duration: Duration(seconds: 5),
      ),
    );
  }

  void showDeleteTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Limpar Tudo?"),
        content: Text("Você tem certeza que deseja apagar todas as tarefas?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              deleteAllTodos();
            },
            child: Text(
              "Limpar Tudo",
              style: TextStyle(color: Color(0xff00d7f3)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void deleteAllTodos() {
    setState(() {
      todos.clear();
    });
    todoRepository.saveTodoList(todos);
  }
}
