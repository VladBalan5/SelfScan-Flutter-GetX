import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfscancorafluttergetx/constants/colors.dart';
import 'package:selfscancorafluttergetx/screens/camera_screen/camera_screen_controller.dart';
import 'package:selfscancorafluttergetx/services/api.dart';
import 'package:selfscancorafluttergetx/utils/local_storage.dart';
import 'package:selfscancorafluttergetx/widgets/buttons/custom_button.dart';
import 'package:selfscancorafluttergetx/widgets/quantity_selector/camera_quantity_selector/camera_quantity_selector_controller.dart';
import 'package:selfscancorafluttergetx/widgets/quantity_selector/camera_quantity_selector/camera_quantity_selector_view.dart';

class CameraPopUp extends StatelessWidget {
  final cameraQuantityController = Get.put(CameraQuantitySelectorController());
  final cameraController = Get.put(CameraScreenController());

  String title = '';
  String price = '';
  String imageUrl = '';
  String uom = '';
  String ean = '';
  Function restartScanning = () => {};

  CameraPopUp({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.uom,
    required this.ean,
    required this.restartScanning,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: kBlack.withOpacity(0.5),
        ),
        AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 100,
                height: 100,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$price',
                    style: const TextStyle(
                      fontSize: 16,
                      color: kBlue,
                    ),
                  ),
                  Text(
                    " lei / ${uom}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              (uom == 'buc') ? CameraQuantitySelector() : Container(),
              const SizedBox(
                height: 50,
              ),
              Container(
                child: CustomButton(
                  buttonHeight: 40,
                  buttonText: 'Adauga in cos',
                  buttonFunction: () => {
                    localStorage.addItem(ean, imageUrl),
                    addProductSelfScan(
                      ean,
                      cameraQuantityController.quantity.value,
                    ),
                    restartScanning(),
                    cameraController.getNrProductsAndPrice(),
                    cameraQuantityController.quantity.value = 1,
                  },
                  buttonColor: kBlue,
                  buttonTextColor: kWhite,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: CustomButton(
                  buttonHeight: 40,
                  buttonText: 'Anuleaza',
                  buttonFunction: () => {
                    restartScanning(),
                    cameraQuantityController.quantity.value = 1,
                  },
                  buttonColor: kLightGrey,
                  buttonTextColor: kBlack,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future addProductSelfScan(String? ean, int? quantity) async {
  await addSelfScanningProduct(ean, quantity);
}
