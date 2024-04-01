import 'dart:async';

import 'package:aptitude_test/src/features/app/model/quiz_model/quiz_model.dart';
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
          _Buttons(
            quiz: widget.quiz,
            selectedAnswer: _selectedAnswer,
          ),
          const Spacer(),
          _NextButton(
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

class _Buttons extends StatefulWidget {
  final Quiz quiz;
  final Function(int) selectedAnswer;

  const _Buttons({
    required this.quiz,
    required this.selectedAnswer,
  });

  @override
  State<_Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<_Buttons> {
  String? _selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: widget.quiz.answers.map(
          (e) {
            return _AnswerButton(
                answer: e.answer,
                isSelected: e.answer == _selectedAnswer,
                onPressed: () {
                  widget.selectedAnswer(e.score);
                  setState(
                    () {
                      _selectedAnswer = e.answer;
                    },
                  );
                });
          },
        ).toList(),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  final Function({
    required int score,
    required bool isLast,
  }) buttonNextPressed;

  final bool isSelectedAnswer;
  final int score;
  final bool isLast;

  const _NextButton({
    required this.buttonNextPressed,
    required this.isSelectedAnswer,
    required this.score,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: ElevatedButton(
        onPressed: isSelectedAnswer
            ? () => buttonNextPressed(
                  score: score,
                  isLast: isLast,
                )
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class _AnswerButton extends StatelessWidget {
  final String answer;
  final VoidCallback onPressed;
  final bool isSelected;

  const _AnswerButton({
    required this.answer,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isSelected ? Colors.deepPurple.withOpacity(0.15) : Colors.white,
            surfaceTintColor:
                isSelected ? Colors.deepPurple.withOpacity(0.15) : Colors.white,
            shadowColor:
                isSelected ? Colors.deepPurple.withOpacity(0.15) : Colors.white,
            side: BorderSide(
                color: isSelected ? Colors.black : Colors.grey,
                width: isSelected ? 1.5 : 1.0),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    answer,
                    softWrap: true,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              isSelected
                  ? Container(
                      width: 25,
                      height: 25,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepPurple,
                      ),
                      child: const Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    )
                  : Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
