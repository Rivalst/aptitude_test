import 'package:aptitude_test/src/features/app/model/quiz_model/quiz_model.dart';
import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final Quiz quiz;
  final Function({
    required BuildContext context,
    required int score,
    required bool isLast,
  }) buttonNextPressed;

  const QuizCard({
    required this.quiz,
    required this.buttonNextPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            quiz.questionText,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          _Buttons(
            quiz: quiz,
          ),
          const Spacer(),
          _NextButton(buttonNextPressed: buttonNextPressed)
        ],
      ),
    );
  }
}

class _Buttons extends StatefulWidget {
  final Quiz quiz;

  const _Buttons({
    required this.quiz,
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
              onPressed: () => setState(
                () {
                  _selectedAnswer = e.answer;
                },
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  final Function({
    required BuildContext context,
    required int score,
    required bool isLast,
  }) buttonNextPressed;

  const _NextButton({required this.buttonNextPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: ElevatedButton(
        onPressed: () => buttonNextPressed(
          context: context,
          score: 0,
          isLast: false,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
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
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shadowColor: Colors.white,
            side: const BorderSide(
              color: Colors.grey,
            ),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
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
                      fontWeight: FontWeight.bold,
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
