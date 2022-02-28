import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfscancorafluttergetx/constants/colors.dart';
import 'package:selfscancorafluttergetx/widgets/quantity_selector/camera_quantity_selector/camera_quantity_selector_controller.dart';

class CameraQuantitySelector extends StatelessWidget {
  final cameraQuantityController = Get.put(CameraQuantitySelectorController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40,
          child: MaterialButton(
            color: kBlue,
            elevation: 0,
            padding: const EdgeInsets.all(5),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                bottomLeft: Radius.circular(60),
              ),
            ),
            onPressed: () => {
              cameraQuantityController.decrease(),
            },
            child: const Icon(
              Icons.remove,
              color: kWhite,
            ),
          ),
        ),
        Obx(
          () => Container(
            padding: cameraQuantityController.quantity.value < 10
                ? const EdgeInsets.only(left: 5, right: 5, top: 9, bottom: 9)
                : const EdgeInsets.only(
                    left: 4.5, right: 4.5, top: 10, bottom: 10),
            decoration: BoxDecoration(
                border: Border.all(
              width: 1,
              color: kLightGrey,
            )),
            child: Text(
              " ${cameraQuantityController.quantity.value} buc ",
              style: cameraQuantityController.quantity.value < 10
                  ? const TextStyle(
                      fontSize: 14,
                      color: kBlue,
                    )
                  : const TextStyle(
                      fontSize: 12,
                      color: kBlue,
                    ),
            ),
          ),
        ),
        Container(
          width: 40,
          child: MaterialButton(
            color: kBlue,
            elevation: 0,
            padding: const EdgeInsets.all(5),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
            ),
            onPressed: () => {
              cameraQuantityController.increase(),
            },
            child: const Icon(
              Icons.add,
              color: kWhite,
            ),
          ),
        ),
      ],
    );
  }
}
