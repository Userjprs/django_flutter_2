import 'dart:convert';

import 'package:django_flutter_2/models/quiz_question.dart';
import 'package:http/http.dart' as http;

class QuestionsService {
  static Future<List<QuizQuestion>> obtenerPreguntas(int quizId) async {
    try {
      final url = Uri.parse(
        // 'https://backend-quiz-ebon.vercel.app/api/quizzes/2/',
        'https://backend-quiz-ebon.vercel.app/api/quizzes/$quizId/',
      );
      final respuesta = await http.get(url);

      // print('RESPUESTA: ${respuesta.statusCode}');
      // print('BODY: ${respuesta.body}');
      if (respuesta.statusCode == 200) {
        // print(respuesta.body);
        final data = jsonDecode(respuesta.body);
        // print('Preguntas encontradas: ${data['questions']}');

        // verificar si question existe
        if (data.containsKey('questions') &&
            data['questions'] is List &&
            data['questions'].isNotEmpty) {
          final preguntas = data['questions'] as List;
          return preguntas.map((q) => QuizQuestion.fromJson(q)).toList();
        } else {
          throw Exception('No hay preguntas en la respuesta');
        }
      } else {
        throw Exception('Error: ${respuesta.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al obtener las preguntas');
    }
  }
}
