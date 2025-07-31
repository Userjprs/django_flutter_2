import 'package:django_flutter_2/components/questions_summary.dart';
import 'package:django_flutter_2/models/quiz_question.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.questions,
  });

  // mostrar opciones elegidas
  final List<String> chosenAnswers;
  final List<QuizQuestion> questions;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'questions_index': i,
        'question': questions[i].questionText,
        'correct_answer': questions[i].correctAnswer,
        'user_answer': chosenAnswers[i],
      });

      print('Pregunta #${i + 1}');
      print('Texto: ${questions[i].questionText}');
      print('Correcta: ${questions[i].correctAnswer}');
      print('Elegida: ${chosenAnswers[i]}');
    }
    return summary;
  }

  // return summary;

  @override
  Widget build(BuildContext context) {
    // devolver numero total de preguntas y num de preguntas correctas
    final numTotalQuestions = questions.length;
    final numCorrectQuestions =
        getSummaryData().where((data) {
          return data['user_answer'] == data['correct_answer'];
        }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
            ),
            const SizedBox(height: 30),
            // const Text('List of answers and questions'),
            QuestionSummary(getSummaryData()),
            const SizedBox(height: 30),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
              icon: const Icon(Icons.restart_alt),
              onPressed: () {},
              label: const Text('Restar Quiz!'),
            ),
          ],
        ),
      ),
    );
  }
}
