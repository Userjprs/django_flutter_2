// import 'dart:convert';

import 'package:django_flutter_2/components/answer_button.dart';
import 'package:django_flutter_2/models/quiz_question.dart';
import 'package:flutter/material.dart';

class QuestionsScreen extends StatefulWidget {
  final int quizId;
  final List<QuizQuestion> preguntas;
  final VoidCallback onNextQuiz;

  const QuestionsScreen({
    super.key,
    required this.quizId,
    required this.preguntas,
    required this.onNextQuiz,
  });

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final List<QuizQuestion> listaPreguntas = [];
  var currentQuestionIndex = 2; //  inician las preguntas

  void responder() {
    if (currentQuestionIndex < widget.preguntas.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      widget.onNextQuiz(); // ← Aquí cambia al siguiente quiz
    }
  }

  // recorrer las preguntas
  void answerQuestion() {
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final QuizQuestion currentQuestion = widget.preguntas[currentQuestionIndex];
    // final currentQuestionText =
    //     widget.preguntas.isNotEmpty
    //         ? widget.preguntas[currentQuestionIndex].questionText
    //         : 'Cargando...';

    // return const Center(child: Text('Questions Screen'));
    return Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Text('The question...'),
            Text(
              textAlign: TextAlign.center,
              currentQuestion.questionText,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 30),
            // ...currentQuestion.options.map((answer) {
            ...currentQuestion.getShuffledAnswers().map((options) {
              // return AnswerButton(text: options, onTap: () {});
              return AnswerButton(text: options, onTap: answerQuestion);
            }),
          ],
        ),
      ),
    );
  }
}
