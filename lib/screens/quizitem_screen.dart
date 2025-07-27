import 'package:django_flutter_2/components/quizitem_button.dart';
import 'package:django_flutter_2/data/quizitem_service.dart';
import 'package:django_flutter_2/models/quiz_item.dart';
import 'package:flutter/material.dart';

class QuizItemScreen extends StatefulWidget {
  // cambiar la pantalla a questions_screen
  final void Function(int quizId) resolveQuiz;

  const QuizItemScreen({super.key, required this.resolveQuiz});

  @override
  _QuizItemScreenState createState() => _QuizItemScreenState();
}

class _QuizItemScreenState extends State<QuizItemScreen> {
  // asignar quiz a botones
  List<QuizItem> quizzes = []; // arreglo

  // varibles
  bool cargando = true;
  String? errorMensaje;

  @override
  void initState() {
    super.initState();
    cargarQuizzes(); // aqui se usa la conexion
  }

  Future<void> cargarQuizzes() async {
    try {
      final data = await QuizitemService.obtenerQuizzes();
      setState(() {
        quizzes = data;
        cargando = false;
      });
    } catch (e) {
      setState(() {
        errorMensaje = e.toString();
        cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cargando) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMensaje != null) {
      return Center(child: Text('Error: $errorMensaje'));
    }

    // return const Center(child: Text('Quiz Item'));
    return Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Text('Quiz Items...'),
            Text(
              textAlign: TextAlign.center,
              'Quiz List Api',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 30),

            ...quizzes.map(
              (quiz) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: QuizItemButton(
                  text: quiz.title,
                  // onTap: () {},
                  // onTap: widget.resolveQuiz,
                  onTap: () {
                    widget.resolveQuiz(quiz.id);
                  },
                  // onTap: () {
                  //   // desde aqui se puede navegar a QuestionsScreen
                  //   print('Quiz seleccionado: ${quiz.id}');
                  // },
                ),
              ),
            ),
            // QuizItemButton(text: 'Item1', onTap: () {}),
            // SizedBox(height: 30),
            // QuizItemButton(text: 'Item2', onTap: () {}),
            // SizedBox(height: 30),
            // QuizItemButton(text: 'Item3', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
