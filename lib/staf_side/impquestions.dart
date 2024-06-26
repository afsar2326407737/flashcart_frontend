import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../student_side/flash_cart.dart';
import '../url/url.dart';


class ImpQuestions extends StatefulWidget {
  const ImpQuestions({super.key});
  @override
  State<ImpQuestions> createState() => _ImpQuestionsState();
}

class _ImpQuestionsState extends State<ImpQuestions> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _questionsController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  Future<void> _insert(BuildContext context) async {
    final url = Uri.parse(URL_DATA);
    final response = await http.post(
        url,
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String,String>{
          'email':_emailController.text,
          'question':_questionsController.text,
          'answer':_answerController.text,
        })
    );
    if ( response.statusCode == 200){
      print("your questions were inserted ");
      Navigator.pushNamed(
          context, '/flashcart'
      );
    }
    else if (response.statusCode == 400){
      print("error");
    }
    else {
      print("unable to connect");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Insert Your Questions ",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
          centerTitle: true,
        actions: [
          IconButton(onPressed:(){
            Navigator.pop(context);
          }
              , icon: Icon(Icons.exit_to_app,
              )
          ),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/flashcart');
          }, icon: Icon(Icons.home))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _questionsController,
              decoration: InputDecoration(
                labelText: "Questions",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.question_answer_rounded),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(
                labelText: "answer",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.question_answer)
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){_insert(context);}, child:
            Text("Insert",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
            ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              ),
            )
          ],
        ),
      ),
    );
  }
}
