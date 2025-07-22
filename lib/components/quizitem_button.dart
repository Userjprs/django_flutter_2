import 'package:flutter/material.dart';

class QuizItemButton extends StatelessWidget {
  const QuizItemButton({super.key, required this.text, required this.onTap});

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onTap, child: Text(text));
  }
}
