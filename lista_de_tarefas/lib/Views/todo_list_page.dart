// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:lista_de_tarefas/Models/Item.dart';
import 'package:lista_de_tarefas/Views/todo_item.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<Item> listaTarefa = [
    Item(hora: DateTime.now(), title: "title", desc: "desc"),
  ];

  int? deletedPos;
  Item? deletedItem;

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  DateTime? hr;
  String? msg; 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff42403F), Color(0xff555251)],
              ),
            ),
            child: Scaffold(
              backgroundColor: Color(0xff42403F),
              appBar: AppBar(
                backgroundColor: Color(0xff42403F),
                foregroundColor: Colors.white,
              ),
              drawer: Drawer(),
              body: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Today's",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Schedule",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    EasyDateTimeLine(
                      initialDate: DateTime.now(),
                      onDateChange: (selectedDate) {
                        //`selectedDate` the new date selected.
                      },
                      activeColor: Colors.transparent,
                      headerProps: const EasyHeaderProps(
                          monthStyle: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                          monthPickerType: MonthPickerType.switcher,
                          dateFormatter: DateFormatter.fullDateDMonthAsStrY(),
                          selectedDateStyle: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                          showMonthPicker: false),
                      dayProps: const EasyDayProps(
                        activeDayStyle: DayStyle(
                          borderRadius: 32.0,
                        ),
                        inactiveDayStyle: DayStyle(
                          dayStrStyle: TextStyle(
                            color: Colors.white70,
                          ),
                          dayNumStyle: TextStyle(
                            color: Colors.white70,
                          ),
                          decoration: BoxDecoration(
                            border: null,
                          ),
                        ),
                      ),
                      timeLineProps: const EasyTimeLineProps(
                        hPadding: 10.0, // padding from left and right
                        separatorPadding: 16.0, // padding between days
                      ),
                    ),
                    Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          for (Item item in listaTarefa)
                            ItemTodo(
                              tarefa: item,
                              onDelete: _deleteOneItem,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Color(0xff1CDBE1),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.grey.shade700,
                    title: Text(
                      "Adicionando uma nova Tarefa",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                    content: Container(
                      padding: EdgeInsets.all(18),
                      child: Column(
                        children: [
                          TextField(
                            controller: titleController,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              errorText: msg,
                              errorStyle: TextStyle(
                                color: Colors.redAccent,
                              ),
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              label: Text("Titulo da Tarefa"),
                              hintText: "Ex: Estudar Flutter",
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 240,
                            height: 150,
                            child: TextField(
                              controller: descController,
                              textAlign: TextAlign.start,
                              textAlignVertical: TextAlignVertical.top,
                              maxLines: null,
                              expands: true,
                              decoration: InputDecoration(
                                labelText: 'Descrição da Tarefa',
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                hintText: "Ex: Estudar Widgets, API's e etc",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TimePickerSpinnerPopUp(
                            textStyle: TextStyle(color: Colors.white),
                            mode: CupertinoDatePickerMode.time,
                            initTime: DateTime.now(),
                            onChange: (dateTime) {
                              hr = dateTime;
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                side: BorderSide(
                                  width: 1,
                                  color: Colors.white,
                                ))),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                side: BorderSide(
                                  width: 1,
                                  color: Colors.white,
                                ))),
                        onPressed: () {
                          setState(() {
                            if(titleController.text != ""){
                            setState(() {
                              listaTarefa.add(
                              Item(
                                hora: hr ?? DateTime.now(),
                                title: titleController.text,
                                desc: descController.text,
                              ),
                            );
                            titleController.clear();
                            descController.clear();
                            Navigator.pop(context);
                            });
                            }
                            else{
                              _showDialogError();
                            }
                          });
                        },
                        child: Text(
                          "Salvar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
              shape: CircleBorder(),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
  void _showDialogError(){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Titulo Necessário"),
      content: Text("O campo Titulo é obrigatório"),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text("OK")),
      ],
    ),);
  }

  void _deleteOneItem(Item t){
    deletedItem = t;
    deletedPos = listaTarefa.indexOf(t);
    setState(() {
      listaTarefa.remove(t);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Tarefa ${t.title} excluída com sucesso!",
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
              listaTarefa.insert(deletedPos!, deletedItem!);
            });
          },
        ),
        duration: Duration(seconds: 5),
      ),
    );
  }
}
