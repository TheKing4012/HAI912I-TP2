import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/quiz_provider.dart';
import '../widgets/question_card.dart';

class QuizzPage extends StatelessWidget {
  const QuizzPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (quizProvider.currentQuestion.imagePath != null)
              Image.asset(
                quizProvider.currentQuestion.imagePath!,
                height: 150,
                fit: BoxFit.contain,
              ),
            if (quizProvider.currentQuestion.imagePath != null) const SizedBox(height: 20),
            QuestionCard(questionText: quizProvider.currentQuestion.questionText),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => quizProvider.checkAnswer(true),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: const Text('VRAI'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => quizProvider.checkAnswer(false),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: const Text('FAUX'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (quizProvider.currentIndex == quizProvider.totalQuestions - 1)
              Text(
                'Votre score : ${quizProvider.score}/${quizProvider.totalQuestions}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: quizProvider.resetQuiz,
              child: const Text('Recommencer'),
            ),
          ],
        ),
      ),
    );
  }
}
