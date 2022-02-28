import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfscancorafluttergetx/constants/colors.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: kBlue,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
