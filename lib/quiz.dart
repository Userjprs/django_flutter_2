import 'package:django_flutter_2/screens/questions_screen.dart';
import 'package:django_flutter_2/screens/quizitem_screen.dart';
import 'package:django_flutter_2/screens/results_screen.dart';
import 'package:django_flutter_2/screens/start_screen.dart';
import 'package:flutter/material.dart';

import 'data/questions_service.dart';
import 'models/quiz_question.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  // para pasar a quizitem_screen
  // Widget activeScreen = const StartScreen();
  // Widget? startScreen;
  // Widget activeScreen = const StartScreen(switchScreen);
  // Widget? activeScreen;

  // void switchScreen() {
  //   setState(() {
  //     activeScreen = const QuizItemScreen();
  //   });
  // }

  // elegir la respuesta correcta
  List<String> selectedAnswers = [];

  // otra forma de cambiar pantalla
  var activeScreen = 'start-screen';
  List<QuizQuestion> listaPreguntas = [];

  // cambiar pantalla de seleccion de quizzes
  void switchScreenItem() {
    setState(() {
      activeScreen = 'quizitem-screen';
    });
  }

  // inicializar switchScreenQuestions
  // @override
  // void initState() {
  //   super.initState();
  // }

  // cambiar a pantalla de pregutas
  void switchScreenQuestions() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  // cuando se selecciona un quiz desde QuizItemScreen
  void resolveQuiz() {
    // Implement your logic for resolving the quiz here
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  // iniciar cargarPreguntas
  @override
  void initState() {
    super.initState();
    // cargarPreguntas(quizId);
  }

  // metodo
  // int quizId = 0; // Define quizId with a default value or set it dynamically

  // Future<void> cargarPreguntas() async {
  //   try {
  //     final preguntas = await QuestionsService.obtenerPreguntas(quizId);
  //     setState(() {
  //       listaPreguntas = preguntas;
  //     });
  //   } catch (e) {
  //     print('Error al cargar preguntas: $e');
  //   }
  // }

  int quizId = 2;

  void cargarPreguntas(int quizIdSeleccionado) async {
    // if (quizId > 6) return; // fuera de rango

    try {
      final preguntas = await QuestionsService.obtenerPreguntas(
        quizIdSeleccionado,
      );
      setState(() {
        listaPreguntas = preguntas;
        quizId = quizIdSeleccionado;
        activeScreen = 'questions-screen';
        // quizId++; // avanzar al siguiente
      });
    } catch (e) {
      print('Error con quiz ID $quizIdSeleccionado: $e');
    }
  }

  void avanzarAlSiguienteQuiz() {
    cargarPreguntas(quizId); // ya incrementa el quizId automáticamente
  }

  // funcion para elegir la respuesta correcta(metodo):
  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    // condicion para volver a pantalla inicial
    if (selectedAnswers.length == listaPreguntas.length) {
      // selectedAnswers = [];
      // resetQuiz();
      setState(() {
        // selectedAnswers = [];
        // activeScreen = 'start-screen';
        activeScreen = 'results-screen';
      });
    }
  }

  // funcion para reiniciar quiz
  void resetQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'start-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    // 2da forma de cambiar pantalla
    // final screenWidget =
    //     activeScreen == 'start-screen'
    //         ? StartScreen(switchScreen)
    //         : const QuizItemScreen();
    // variable
    Widget screenWidget;

    // return QuizItemScreen(
    //   resolveQuiz: (quizId) {
    //     cargarPreguntas(
    //       quizId,
    //     ); //  esta función carga preguntas del quiz con ese ID
    //   },
    // );

    if (activeScreen == 'start-screen') {
      screenWidget = StartScreen(switchScreenItem);
    } else if (activeScreen == 'quizitem-screen') {
      // screenWidget = QuizItemScreen(resolveQuiz: resolveQuiz);
      screenWidget = QuizItemScreen(
        resolveQuiz: (quizId) {
          cargarPreguntas(quizId);
        },
      );
    } else if (activeScreen == 'questions-screen') {
      // screenWidget = QuestionsScreen();
      // screenWidget = QuestionsScreen(preguntas: listaPreguntas, quizId: quizId);
      screenWidget = QuestionsScreen(
        preguntas: listaPreguntas,
        quizId: quizId,
        // onNextQuiz: avanzarAlSiguienteQuiz,
        onNextQuiz: avanzarAlSiguienteQuiz,
        onSelectAnswer: (chooseAnswer),
      );
    } else if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        questions: listaPreguntas, // revisar
      );
    } else {
      screenWidget = Center(child: Text('Pantalla desconocida'));
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 122, 70, 212),
                Color.fromARGB(255, 71, 38, 128),
              ],
            ),
          ),
          // child: const Text('Start Screen'),
          // child: const StartScreen(), // cambia de pantalla
          // child: activeScreen, // cambia de pantalla
          // child: screenWidget, // 2da forma de carbiar pantalla
          child: screenWidget, // 2da forma de carbiar pantalla
        ),
      ),
    );
  }
}
