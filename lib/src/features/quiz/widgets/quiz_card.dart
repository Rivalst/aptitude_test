import 'dart:async';

import 'package:aptitude_test/src/features/app/model/quiz_model/quiz_model.dart';
import 'package:aptitude_test/src/features/quiz/widgets/buttons.dart';
import 'package:flutter/material.dart';

class QuizCard extends StatefulWidget {
  final Quiz quiz;
  final bool isLast;
  final int seconds;

  final Function({
    required int score,
    required bool isLast,
  }) buttonNextPressed;

  final Function() updateTime;

  const QuizCard({
    required this.quiz,
    required this.buttonNextPressed,
    required this.isLast,
    required this.seconds,
    required this.updateTime,
    super.key,
  });

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  late Timer? _timer;

  @override
  void initState() {
    _startCountdown();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            widget.quiz.questionText,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          Buttons(
            quiz: widget.quiz,
            selectedAnswer: _selectedAnswer,
          ),
          const Spacer(),
          NextButton(
            buttonNextPressed: widget.buttonNextPressed,
            isSelectedAnswer: _isSelectedAnswer,
            score: _score,
            isLast: widget.isLast,
          )
        ],
      ),
    );
  }

  void _selectedAnswer(int score) {
    setState(() {
      _isSelectedAnswer = true;
      _score = score;
    });
  }

  void _startCountdown() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      if (widget.seconds <= 0) {
        timer.cancel();
        if (widget.isLast) {
          widget.buttonNextPressed(
            score: _score,
            isLast: widget.isLast,
          );
        } else {
          widget.buttonNextPressed(
            score: _score,
            isLast: widget.isLast,
          );
        }
      } else {
        widget.updateTime();
      }
    });
  }

  bool _isSelectedAnswer = false;
  int _score = 0;
}
