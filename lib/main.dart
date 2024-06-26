import 'package:flashcart/staf_side/impquestions.dart';
import 'package:flashcart/staf_side/login.dart';
import 'package:flashcart/staf_side/signup.dart';
import 'package:flashcart/student_side/flash_cart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => SignUp(),
        '/login':(contxt) => Login(),
        '/importdata':(context) =>ImpQuestions(),
        '/flashcart':(context) => DataListScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}