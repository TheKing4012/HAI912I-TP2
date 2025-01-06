import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../events/quiz_event.dart';
import '../states/quiz_state.dart';
import '../../data/models/question.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
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

  QuizBloc()
      : super(QuestionDisplayed(
    question: Question(
      questionText: "La France a dû céder l'Alsace et la Moselle à l'Allemagne après 1870.",
      isCorrect: true,
      imagePath: 'assets/france.jpg',
    ),
    score: 0,
    currentIndex: 0,
    totalQuestions: 2,
  )) {
    on<CheckAnswer>((event, emit) {
      if (event.userChoice == _questions[_currentIndex].isCorrect) {
        _score++;
      }
      _currentIndex++;
      if (_currentIndex < _questions.length) {
        emit(
          QuestionDisplayed(
            question: _questions[_currentIndex],
            score: _score,
            currentIndex: _currentIndex,
            totalQuestions: _questions.length,
          ),
        );
      } else {
        emit(QuizCompleted(score: _score, totalQuestions: _questions.length));
      }
    });

    on<NextQuestion>((event, emit) {
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
        emit(
          QuestionDisplayed(
            question: _questions[_currentIndex],
            score: _score,
            currentIndex: _currentIndex,
            totalQuestions: _questions.length,
          ),
        );
      }
    });

    on<ResetQuiz>((event, emit) {
      _score = 0;
      _currentIndex = 0;
      emit(
        QuestionDisplayed(
          question: _questions[_currentIndex],
          score: _score,
          currentIndex: _currentIndex,
          totalQuestions: _questions.length,
        ),
      );
    });
  }
}

