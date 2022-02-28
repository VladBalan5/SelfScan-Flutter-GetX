import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfscancorafluttergetx/constants/colors.dart';
import 'package:selfscancorafluttergetx/screens/basket_screen/basket_screen_controller.dart';
import 'package:selfscancorafluttergetx/services/api.dart';

class BasketQuantitySelector extends StatelessWidget {
  final basketController = Get.put(BasketScreenController());

  var quantity;
  String ean;

  BasketQuantitySelector({
    required this.quantity,
    required this.ean,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 32,
          height: 32,
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
              if (quantity.value > 1)
                {
                  quantity.value--,
                  updateSelfScanningProduct(ean, quantity),
                  basketController.getListOfProducts(),
                }
            },
            child: const Icon(
              Icons.remove,
              color: kWhite,
              size: 20,
            ),
          ),
        ),
        Obx(
          () => Container(
            padding: quantity.value < 10
                ? const EdgeInsets.only(left: 3, right: 3, top: 7, bottom: 7)
                : const EdgeInsets.only(
                    left: 2.5, right: 2.5, top: 8, bottom: 8),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: kLightGrey,
              ),
            ),
            child: Text(
              " ${quantity.value.round()} buc ",
              style: quantity.value < 10
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
          width: 32,
          height: 32,
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
              if (quantity.value < 999)
                {
                  quantity.value++,
                  updateSelfScanningProduct(ean, quantity),
                  basketController.getListOfProducts(),
                }
            },
            child: const Icon(
              Icons.add,
              color: kWhite,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
