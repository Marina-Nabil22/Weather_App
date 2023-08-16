
import 'package:flutter/material.dart';
import 'services/cash_helper.dart';
import 'src/app_root.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  runApp( AppRoot()
  );

}


