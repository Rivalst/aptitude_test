import 'package:aptitude_test/src/core/util/extensions.dart';
import 'package:aptitude_test/src/features/quiz/bloc/quiz_score_bloc.dart';
import 'package:aptitude_test/src/features/quiz/widgets/quiz_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizScoreBloc(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: null,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => null,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: const Color(0xFFebe6fd),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const Text(
                      'Aptitude Test',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      _time.toSecondsString(),
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xFFf8ecfa),
                    Color.fromARGB(255, 245, 236, 246),
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Color.fromARGB(255, 245, 236, 246),
                    Color(0xFFf8ecfa),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: QuizView(
                updateTime: _updateTime,
                seconds: _time,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateTime(bool isReset) {
    if (isReset) {
      setState(() {
        _time = 10;
      });
    } else {
      setState(() {
        _time--;
      });
    }
  }

  int _time = 10;
}
