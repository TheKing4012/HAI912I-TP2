import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/blocs/weather_bloc.dart';
import '../../data/repositories/weather_repository.dart';
import '../widgets/weather_content.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Météo'),
      ),
      body: BlocProvider(
        create: (context) => WeatherBloc(WeatherRepository()),
        child: WeatherContent(),
      ),
    );
  }
}
