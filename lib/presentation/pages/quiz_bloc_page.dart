import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/blocs/quiz_bloc.dart';
import '../../business_logic/events/quiz_event.dart';
import '../../business_logic/states/quiz_state.dart';
import '../widgets/question_card.dart';

class QuizzBlocPage extends StatelessWidget {
  const QuizzBlocPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quizz avec BLoC'),
          centerTitle: true,
        ),
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state is QuestionDisplayed) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.question.imagePath != null)
                      Image.asset(
                        state.question.imagePath!,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    if (state.question.imagePath != null) const SizedBox(height: 20),
                    QuestionCard(questionText: state.question.questionText),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<QuizBloc>(context).add(CheckAnswer(true));
                          },
                          child: const Text('VRAI'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<QuizBloc>(context).add(CheckAnswer(false));
                          },
                          child: const Text('FAUX'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Score : ${state.score}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            } else if (state is QuizCompleted) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Quiz terminé !\nScore final : ${state.score}/${state.totalQuestions}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<QuizBloc>(context).add(ResetQuiz());
                      },
                      child: const Text('Recommencer'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink(); // État par défaut
          },
        ),
      ),
    );
  }
}
