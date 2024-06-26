import 'dart:convert';
import 'package:flashcart/staf_side/impquestions.dart';
import 'package:flashcart/url/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Future<void> _login(BuildContext context) async {
    final url = Uri.parse(URL_LOGIN);
    final response = await http.post(
      url,
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,String>{
        'email':emailController.text,
        'password':passwordController.text,
      })
    );
    if ( response.statusCode == 200){
      SnackBar(content: Text("Login Succesfull",
      style:TextStyle(
        color: Colors.white
      )
      ),
      );
      Navigator.pushNamed(
          context, '/importdata'
      );
    }
    else if (response.statusCode == 400){
      SnackBar(content: Text("Check the id or password ", style: TextStyle(
        color: Colors.white
      ),
      ),
      );
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
          "Login",
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
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _login(context);
              },
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}