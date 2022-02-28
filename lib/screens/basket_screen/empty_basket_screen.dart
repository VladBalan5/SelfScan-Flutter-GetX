import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfscancorafluttergetx/constants/colors.dart';
import 'package:selfscancorafluttergetx/screens/basket_screen/basket_screen_controller.dart';
import 'package:selfscancorafluttergetx/screens/camera_screen/camera_screen_view.dart';
import 'package:selfscancorafluttergetx/widgets/appbar/custom_appbar.dart';
import 'package:selfscancorafluttergetx/widgets/buttons/custom_button.dart';

class EmptyBasketScreen extends StatelessWidget {
  final basketController = Get.put(BasketScreenController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: kEmptyBackground,
        child: Column(
          children: [
            CustomAppBar(title: 'Cos cumparaturi', right: Container()),
            screenHeight > 700
                ? const SizedBox(
                    height: 180,
                  )
                : const SizedBox(
                    height: 40,
                  ),
            Image.asset('images/basketgol.png'),
            const SizedBox(
              height: 35,
            ),
            const Text(
              'cora self-scanning',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 17, color: kDarkGrey),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Text(
                  'In acest moment, nu ai niciun produs in cos. Pentru adaugarea unui produs, apasa "Scaneaza produs".',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: kDarkGrey,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: CustomButton(
                buttonHeight: 45,
                buttonText: 'Scaneaza produs',
                buttonFunction: () => {
                  basketController.getListOfProducts(),
                  Get.to(() => CameraScreen()),
                },
                buttonColor: kBlue,
                buttonTextColor: kWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
