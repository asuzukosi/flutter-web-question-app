import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../models/answer.dart';

class QuestionAnswerPage extends StatefulWidget {
  const QuestionAnswerPage({Key? key}) : super(key: key);

  @override
  _QuestionAnswerPageState createState() => _QuestionAnswerPageState();
}

class _QuestionAnswerPageState extends State<QuestionAnswerPage> {
  // Text editing controller
  final TextEditingController _questionFieldcontroller =
      TextEditingController();

  // to store the current answer object
  Answer _currentAnswer = Answer("", "");

  // scalfhold key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  // Handle the process of getting response
  _handleGetAnswer() async {
    if (_questionFieldcontroller.text == null ||
        !_questionFieldcontroller.text.isNotEmpty &&
            _questionFieldcontroller.text.trim()[-1] != "?") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Response must be a question"),
          duration: Duration(seconds: 5)));
      return;
    }
    try {
      var url = Uri.https("www.yesno.wtf", "/api");
      http.Response response = await http.get(url);
      var jsonBody = convert.jsonDecode(response.body);
      var answer = Answer.fromMap(jsonBody);
      setState(() {
        _currentAnswer = answer;
      });
      print(answer);
    } catch (err, stacktrace) {
      print(err);
    }
  }

  _resetGame() {
    setState(() {
      var answer = Answer("", "");
      _currentAnswer = answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: const Center(child: Text("I Know everything")),
            elevation: 0,
            backgroundColor: Colors.teal),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    controller: _questionFieldcontroller,
                    decoration: const InputDecoration(
                        labelText: 'Ask a Question',
                        border: OutlineInputBorder()),
                  )),
              const SizedBox(height: 10),
              if (_currentAnswer.image != "")
                Stack(
                  children: [
                    Container(
                        height: 250,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(_currentAnswer.image)),
                        )),
                    Positioned.fill(
                        bottom: 20,
                        right: 20,
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              _currentAnswer.answer,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                              ),
                            )))
                  ],
                ),
              const SizedBox(width: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    ElevatedButton(
                      onPressed: _handleGetAnswer,
                      child: const Text("Get Answer"),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                        onPressed: _resetGame, child: const Text("reset game"))
                  ])
            ]));
  }
}
