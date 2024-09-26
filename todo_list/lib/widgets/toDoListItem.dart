// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/models/todo.dart';

class ToDoListItem extends StatefulWidget {
  const ToDoListItem({required this.todo, required this.onDelete, super.key});

  final Todo todo;
  final Function(Todo) onDelete;

  @override
  State<ToDoListItem> createState() => _ToDoListItemState();
}

class _ToDoListItemState extends State<ToDoListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topLeft: Radius.circular(5)),
            color: Colors.grey[200],
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                DateFormat('dd/MM/yyyy').format(widget.todo.dateTime),
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                widget.todo.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        endActionPane: ActionPane(motion: BehindMotion(),extentRatio: 0.25, children: [
          SlidableAction(
            onPressed: (context) {
              widget.onDelete(widget.todo);
            },
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: "Excluir",
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
          ),
        ]),
      ),
    );
  }
}
