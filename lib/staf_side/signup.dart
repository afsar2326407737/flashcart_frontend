import 'package:flashcart/url/url.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Import your other pages here
import 'impquestions.dart';

class SignUp extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conPasswordController = TextEditingController();

  Future<void> sendDataToServer(BuildContext context) async {
    final url = Uri.parse(URL_SIGNUP);

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name' : nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'cpassword': conPasswordController.text,
        }),
      );
        if (response.statusCode == 201) {
          print('signin successfully');

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Signed in succesfully ",
                style: TextStyle(
                  color: Colors.white,
                ),))
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ImpQuestions()),
          );
        }else if (response.statusCode == 400 ){
          print("the email should not be empty");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("email should not empty ",
            style: TextStyle(
              backgroundColor: Colors.red,
              color: Colors.black,
            ),))
          );
        }
        else {
          print('Failed to send data. Error: ${response.statusCode}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to sign up. Please try again later.')),
          );
        }
      }catch (e) {
      print('Exception during HTTP request: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again later.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SignUp",
          style: TextStyle(fontSize: 20, color: Colors.white),
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
              controller: nameController,
              decoration: InputDecoration(
                labelText: "name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
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
            SizedBox(height: 20,),
            TextField(
              controller: conPasswordController,
              decoration: InputDecoration(
                labelText: "CPassword",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () => sendDataToServer(context),
              child: Text(
                "Signup",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 10,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(
                context,'/login'
              );
            }, child:
            Text("Login",
            style:TextStyle(
              color: Colors.white,
            ),
            ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(
                  context,
                  '/importdata'
              );
            }, child:
            Text("insert",
              style:TextStyle(
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
