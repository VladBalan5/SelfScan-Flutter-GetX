import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfscancorafluttergetx/constants/colors.dart';
import 'package:selfscancorafluttergetx/screens/basket_screen/basket_screen_controller.dart';

class CameraBottomContainer extends StatelessWidget {
  final basketController = Get.put(BasketScreenController());

  String nrProducts;
  String estimate;
  BuildContext context;

  CameraBottomContainer(
    this.context,
    this.nrProducts,
    this.estimate,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 13,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 13,
            width: MediaQuery.of(context).size.width,
            color: kWhite,
            padding: const EdgeInsets.all(10),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 5,
                  child: ElevatedButton(
                    onPressed: () => {
                      Get.back(),
                      basketController.getListOfProducts(),
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.shopping_cart_outlined),
                        Text(
                          '$nrProducts produse',
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    )),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Total estimativ: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '$estimate LEI',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
