class QuizQuestion {
  // variables
  final int id;
  final String questionText;
  final String correctAnswer;
  final String questionType;
  final List<String> options;
  final int quizId;

  QuizQuestion({
    required this.id,
    required this.questionText,
    required this.correctAnswer,
    required this.questionType,
    required this.options,
    required this.quizId,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'],
      questionText: json['question_text'],
      correctAnswer: json['correct_answer'],
      questionType: json['question_type'],
      options: List<String>.from(json['options']),
      quizId: json['quiz'],
    );
  }

  // pasar a las siguientes preguntas
  List<String> getShuffledAnswers() {
    final shuffleList = List.of(options);
    shuffleList.shuffle();
    return shuffleList;
  }
}
