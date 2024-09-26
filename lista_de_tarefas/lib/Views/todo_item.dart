// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lista_de_tarefas/Models/Item.dart';


class ItemTodo extends StatefulWidget {
  Item tarefa;
  Function(Item) onDelete;
  ItemTodo({required this.tarefa , required this.onDelete, super.key});

  @override
  State<ItemTodo> createState() => _ItemTodoState();
}

class _ItemTodoState extends State<ItemTodo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient:
                LinearGradient(colors: [Color(0xff555352), Color(0xff555453)]),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('kk:mm').format(widget.tarefa.hora),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.tarefa.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              IconButton(
                onPressed: () {
                  widget.onDelete(widget.tarefa);
                },
                icon: Icon(Icons.check_circle_outline,
                color: Color(0xff1CDBE1),
                size: 28,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
