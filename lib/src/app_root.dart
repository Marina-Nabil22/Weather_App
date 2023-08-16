import 'package:flutter/material.dart';
import 'package:weather_app_2/bloc/cubit/weather_cubit.dart';
import '../../services/weather_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../views/home_screen.dart';
class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherCubit(WeatherService()),
        ),

      ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
