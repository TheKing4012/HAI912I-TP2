import 'package:flutter/material.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  final List<Question> _questions = [
    Question(
      questionText: "La France a dû céder l'Alsace et la Moselle à l'Allemagne après 1870.",
      isCorrect: true,
      imagePath: 'assets/france.jpg',
    ),
    Question(
      questionText: "Flutter utilise Java comme langage principal.",
      isCorrect: false,
      imagePath: null,
    ),
  ];

  int _currentIndex = 0;
  int _score = 0;

  Question get currentQuestion => _questions[_currentIndex];
  int get currentIndex => _currentIndex;
  int get totalQuestions => _questions.length;
  int get score => _score;

  void checkAnswer(bool userChoice) {
    if (userChoice == currentQuestion.isCorrect) {
      _score++;
    }
    _currentIndex = (_currentIndex + 1) % _questions.length;
    notifyListeners();
  }

  void resetQuiz() {
    _score = 0;
    _currentIndex = 0;
    notifyListeners();
  }
}
