import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/quiz_item.dart';

class QuizitemService {
  static Future<List<QuizItem>> obtenerQuizzes() async {
    try {
      // final url = Uri.parse('http://10.0.2.2:8000/api/quizzes/');
      final url = Uri.parse(
        'https://backend-quiz-ebon.vercel.app/api/quizzes/?format=json',
      );
      final respuesta = await http.get(url);

      if (respuesta.statusCode == 200) {
        final datos = jsonDecode(respuesta.body) as List;
        return datos.map((q) => QuizItem.fromJson(q)).toList();
      } else {
        throw Exception('Error: ${respuesta.statusCode}');
      }
    } catch (e) {
      throw Exception('No se pudo conectar con el servidor: $e');
    }
  }
}
