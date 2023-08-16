import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/weather_cubit.dart';
import '../models/weather_model.dart';
import 'search_page.dart';


class HomePage extends StatelessWidget {


  WeatherModel? weatherData;
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: BlocConsumer<WeatherCubit, WeatherState>(builder:
            (context, state) {
          if(state is WeatherLoadingState){
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else if(state is WeatherSuccessState){
            weatherData=BlocProvider.of<WeatherCubit>(context).weatherModel;
            return SuccessCode(weatherData: weatherData);
          }else if(state is WeatherFailureState){
            return Column(
              children: [
                Image(image: AssetImage('assets/images/36860-2-sad-emoji-transparent-image.png'))
                ,ElevatedButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  SearchPage()),
                  );
                }, child: Icon(CupertinoIcons.back,color: Colors.white,
                )),
                Text("SOMETHING WENT ERONG"),
              ],

            );
          }else{
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/images/36860-2-sad-emoji-transparent-image.png'),height: 60),
                    Text('THERE IS NO WEATHER',style: TextStyle( fontSize: 23,fontWeight: FontWeight.w400)),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  SearchPage()),
                      );
                    }, child: Text("search again"))
                  ],
                )

            );
          }
        }
          ,  listener: (context, state) {
            // TODO: implement listener
          },
        )
    );
  }
}

class SuccessCode extends StatelessWidget {
  const SuccessCode({
    Key? key,
    required this.weatherData,
  }) : super(key: key);

  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {

    return Container(

        decoration: BoxDecoration(

          image: DecorationImage(  image: weatherData!.main!.temp !<= 25 ? AssetImage('assets/images/night.png') : AssetImage("assets/images/after_noon.png"),
            fit: BoxFit.fill,),


        ),

        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(

              alignment: AlignmentDirectional.topStart,
              child:  Padding(
                padding: const EdgeInsets.all(43.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(BlocProvider.of<WeatherCubit>(context).cityName!,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(weatherData!.weather![0].main.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(weatherData!.main!.temp!.toInt().toString()+'°',
                      style: TextStyle(
                          fontSize:60,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      ),
                    ),
                    SizedBox(height: 30),

                  ],
                ),
              ),
            ),
            SizedBox(height: 300),
            ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  SearchPage()),
              );
            }, child:Text("search",style: TextStyle(color: Colors.black,fontSize: 25))
                ,  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white),)),
          ],
        )
    );
  }
}
