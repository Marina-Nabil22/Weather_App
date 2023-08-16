
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../models/weather_model.dart';
import '../../services/cash_helper.dart';
import '../../services/weather_service.dart';
part 'weather_state.dart';
class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.waetherService) : super(WeatherInitial());
  static WeatherCubit get(context) => BlocProvider.of(context);
  WeatherService waetherService;
  String? cityName;
  WeatherModel? weatherModel;

  void getWeather({required String cityName}) async{
    emit(WeatherLoadingState());
    try {
      weatherModel=await waetherService.getWeather(cityName: cityName);
      emit(WeatherSuccessState());
    } on Exception catch (e) {
      emit(WeatherFailureState());
    }

  }
}

