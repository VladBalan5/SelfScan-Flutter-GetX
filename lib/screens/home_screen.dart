import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfscancorafluttergetx/constants/colors.dart';
import 'package:selfscancorafluttergetx/screens/basket_screen/basket_screen_view.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Get.to(() => BasketScreen());
              },
              child: Container(
                color: kWhite,
                width: 100,
                height: 100,
                child: Image.asset('images/selfScanning.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
