import 'package:aptitude_test/src/features/app/bloc/quiz_bloc.dart';
import 'package:aptitude_test/src/features/app/model/quiz_model/quiz_model.dart';
import 'package:aptitude_test/src/features/quiz/widgets/quiz_card.dart';
import 'package:aptitude_test/src/features/quiz/widgets/quiz_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  @override
  void initState() {
    _quizzes = context.read<QuizBloc>().state.quizzes!;
    _controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _quizzes.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 28.0,
            vertical: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuizCount(
                quizIndex: index,
                quizLength: _quizzes.length,
              ),
              Expanded(
                child: QuizCard(
                  quiz: _quizzes[index],
                  buttonNextPressed: _buttonNextPressed,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _buttonNextPressed({
    required BuildContext context,
    required int score,
    required bool isLast,
  }) {
    if (isLast) {
      return;
    }

    _controller.nextPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  late List<Quiz> _quizzes;
  late PageController _controller;
}
