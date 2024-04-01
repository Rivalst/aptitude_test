import 'package:aptitude_test/src/features/quiz/bloc/quiz_score_bloc.dart';
import 'package:aptitude_test/src/features/quiz/widgets/quiz_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizScoreBloc(),
      child: Scaffold(
        appBar: AppBar(),
        body: const SafeArea(
          child: QuizView(),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
