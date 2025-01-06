import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tp2_flutter/presentation/pages/quiz_bloc_page.dart';
import 'package:tp2_flutter/presentation/pages/weather_page.dart';
import 'business_logic/blocs/weather_bloc.dart';
import 'data/providers/quiz_provider.dart';
import 'data/repositories/weather_repository.dart';
import 'presentation/pages/quiz_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WeatherBloc(WeatherRepository()),
          ),
          // Tu peux ajouter d'autres BlocProviders ici si nécessaire
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TP2',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/quizz_provider': (context) => const QuizzPage(title: 'Questions/Réponses Provider'),
        '/weather': (context) => const WeatherPage(),
        '/quizz_bloc': (context) => const QuizzBlocPage(), // Route pour le BLoC
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter TP2 - Exercices'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/quizz_provider'),
              child: const Text('Exercice 1 : Quizz Provider'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/quizz_bloc');
              },
              child: const Text('Exercice 2 : Quizz BLoC'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/weather');
              },
              child: const Text('Exercice 2 : Météo'),
            ),
          ],
        ),
      ),
    );
  }
}
