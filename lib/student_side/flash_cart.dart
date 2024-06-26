import 'package:flashcart/url/url.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Data Model Classes
class Question {
  String question;
  String answer;
  String id;

  Question({required this.question, required this.answer, required this.id});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
      id: json['_id'],
    );
  }
}

class Data {
  String id;
  String email;
  List<Question> questions;

  Data({required this.id, required this.email, required this.questions});

  factory Data.fromJson(Map<String, dynamic> json) {
    var list = json['questions'] as List;
    List<Question> questionsList = list.map((i) => Question.fromJson(i)).toList();

    return Data(
      id: json['_id'],
      email: json['email'],
      questions: questionsList,
    );
  }
}

// API Service Class
class ApiService {
  final String apiUrl = URL_GETDATA;

  Future<List<Data>> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Data.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
class DataListScreen extends StatefulWidget {
  @override
  _DataListScreenState createState() => _DataListScreenState();
}

class _DataListScreenState extends State<DataListScreen> {
  late Future<List<Data>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = ApiService().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data from Backend'),

        actions: [
          IconButton(onPressed:(){
            Navigator.pushNamed(context,'/');
          }
              , icon: Icon(Icons.question_answer,
              )
          ),
          IconButton(onPressed:() {
            Navigator.pushNamed(context, '/login');
          }, icon: Icon(Icons.login)
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Data>>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Data>? data = snapshot.data;
              return ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Email: ${data![index].email}',style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: data[index].questions.map((q) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Question: ${q.question}'),
                                Text('Answer: ${q.answer}'),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
