import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  // cambiar pantalla a quizitem_screen
  final void Function() selectQuiz;

  const StartScreen(this.selectQuiz, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // centrar fondo y demas elementos
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/quiz-logo.png', width: 300),
          const SizedBox(height: 80),
          const Text(
            // 'Learn Flutter the fun way!',
            'Learn amazing facts the fun way!',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          // Text('Start Screen'),
          const SizedBox(height: 80),
          OutlinedButton.icon(
            icon: const Icon(Icons.arrow_right),
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
            // onPressed: () {},
            onPressed: selectQuiz,
            label: const Text('Start Quiz'),
          ),
        ],
      ),
    );
  }
}
