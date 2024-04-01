import 'package:aptitude_test/src/features/quiz/widgets/quiz_view.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
        child: QuizView(),
      ),
      backgroundColor: Colors.white,
    );
  }
}
