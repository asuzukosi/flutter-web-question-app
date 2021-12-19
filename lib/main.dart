import 'package:fcc_crash_course/pages/question_answer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const IKnowEverythingApp());
}

class IKnowEverythingApp extends StatelessWidget {
  const IKnowEverythingApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "I know everything",
        home: const QuestionAnswerPage(),
        theme: ThemeData(primarySwatch: Colors.teal));
  }
}
