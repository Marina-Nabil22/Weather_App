import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/cubit/weather_cubit.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';


class SearchPage extends StatelessWidget {
  String? cityName;
  final _formKey = GlobalKey<FormState>();
  TextEditingController searchController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    //  var cubit=WeatherCubit(waetherService);
    return Scaffold(
      appBar: AppBar(
        title: Text('Search a City'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: searchController,
            onChanged: (data)
            {
              cityName = data;
            },
            onSubmitted: (data) async {
              cityName = data;
              // print(searchController.text);

              BlocProvider.of<WeatherCubit>(context).getWeather(cityName: searchController.text!);
              BlocProvider.of<WeatherCubit>(context).cityName=searchController.text;

              Navigator.pop(context);
            },
            decoration: InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              label: Text('search'),
              suffixIcon: GestureDetector(

                  onTap : () async
                  {
                    WeatherService service = WeatherService();
                    WeatherModel? weather =
                    await service.getWeather(cityName: searchController.text!);
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.search)),
              border: OutlineInputBorder(),
              hintText: 'Enter a city',
            ),
          ),
        ),
      ),
    );
  }
}

