import 'package:aptitude_test/src/features/app/bloc/quiz_bloc.dart';
import 'package:aptitude_test/src/features/quiz/quiz_screen.dart';
import 'package:aptitude_test/src/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizzesState>(builder: (context, state) {
      return state.when(
        initial: () {
          return const SplashScreen();
        },
        loading: () {
          return const SplashScreen();
        },
        loaded: (quizzes) {
          return const QuizScreen();
        },
        error: (quizzes, messages) {
          // in this place we can added error screen
          return const ColoredBox(color: Colors.red);
        },
      );
    });
  }
}
