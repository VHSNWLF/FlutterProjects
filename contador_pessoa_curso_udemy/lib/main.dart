// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

  void decrement() {
    setState(() {
      count--;
    });
    print(count);
  }

  void increment() {
    setState(() {
      count++;
    });
    print(count);
  }

  bool get isEmpty => count == 0;
  bool get isFull => count == 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://img.freepik.com/fotos-gratis/superficie-de-madeira-com-vista-para-o-restaurante-vazio_23-2147701348.jpg?w=996&t=st=1718066999~exp=1718067599~hmac=d73221ebcc3c88e441524ac4292fa2fb330d2bea63a0d35b7ea0d83db0ffa0d3'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isFull ? "Lotado" : "Pode entrar!",
              style: TextStyle(
                  fontSize: 30,
                  color: isFull ? Colors.red : Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 100,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: Size(100, 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: isEmpty ? null : decrement,
                  child: Text(
                    "Saiu",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      backgroundColor: isEmpty ? Colors.white.withOpacity(0.2) : Colors.white
                    ),
                  ),
                ),
                SizedBox(
                  width: 32,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: Size(100, 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: isFull ? null : increment,
                  child: Text(
                    "Entrou",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      backgroundColor: isFull ? Colors.white30 : Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
