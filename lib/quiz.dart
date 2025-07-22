import 'package:django_flutter_2/screens/quizitem_screen.dart';
import 'package:django_flutter_2/screens/start_screen.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  // para pasar a quizitem_screen
  // Widget activeScreen = const StartScreen();
  // Widget activeScreen = const StartScreen(switchScreen);
  // Widget? activeScreen;

  // inicializar switchScreen
  // @override
  // void initState() {
  //   super.initState();
  //   activeScreen = StartScreen(switchScreen);
  // }

  // void switchScreen() {
  //   setState(() {
  //     activeScreen = const QuizItemScreen();
  //   });
  // }

  // otra forma de cambiar pantalla
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'quizitem-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    // 2da forma de cambiar pantalla
    final screenWidget =
        activeScreen == 'start-screen'
            ? StartScreen(switchScreen)
            : const QuizItemScreen();

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
          child: screenWidget, // 2da forma de carbiar pantalla
        ),
      ),
    );
  }
}
