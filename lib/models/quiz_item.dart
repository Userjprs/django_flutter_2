class QuizItem {
  // variables
  final int id;
  final String title;

  // constructor
  const QuizItem({required this.id, required this.title});

  factory QuizItem.fromJson(Map<String, dynamic> json) {
    return QuizItem(id: json['id'], title: json['title']);
  }
}
