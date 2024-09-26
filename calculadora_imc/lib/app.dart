// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

class IMCApp extends StatefulWidget {
  const IMCApp({super.key});

  @override
  State<IMCApp> createState() => _IMCAppState();
}

class _IMCAppState extends State<IMCApp> {
  String info = "Informe seus dados!";
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  void resetFields() {
    pesoController.text = "";
    alturaController.text = "";
    info = "Informe seus dados! ";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Calculadora de IMC",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          IconButton(
            onPressed: () => resetFields(),
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.person_2_outlined,
              color: Colors.deepPurpleAccent,
              size: 120,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if(value!.trim() == ""){
                        return "Por favor preencha o campo Peso";
                      }
                      return null;
                    },
                    controller: pesoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(
                        color: Colors.deepPurpleAccent,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ),
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if(value!.trim() == ""){
                        return "Por favor preencha o campo Altura";
                      }
                      return null;
                    },
                    controller: alturaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(
                        color: Colors.deepPurpleAccent,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ),
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if(formKey.currentState!.validate()){
                  double altura = double.parse(alturaController.text) / 100;
                  double peso = double.parse(pesoController.text);
                  double resultado = peso / (altura * altura);
                  setState(() {
                    if (resultado < 18.5) {
                      info =
                          "Baixo peso (IMC = ${resultado.toStringAsPrecision(4)})";
                    } else if (resultado >= 18.5 && resultado < 24.9) {
                      info =
                          "Peso adequado (IMC = ${resultado.toStringAsPrecision(4)})";
                    } else if (resultado >= 25 && resultado < 29.9) {
                      info =
                          "Sobre Peso (IMC = ${resultado.toStringAsPrecision(4)})";
                    } else if (resultado >= 30.0 && resultado < 34.9) {
                      info =
                          "Obesidade grau 1 (IMC = ${resultado.toStringAsPrecision(4)})";
                    }
                  });
                  }
                },
                child: Text(
                  "Calcular",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              info,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
