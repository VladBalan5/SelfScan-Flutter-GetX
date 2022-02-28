import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfscancorafluttergetx/constants/colors.dart';
import 'package:selfscancorafluttergetx/models/product_model.dart';
import 'package:selfscancorafluttergetx/screens/basket_screen/basket_screen_controller.dart';
import 'package:selfscancorafluttergetx/utils/local_storage.dart';
import 'package:selfscancorafluttergetx/widgets/quantity_selector/basket_quantity_selector/basket_quantity_selector.dart';

Widget productCard(ProductModel product) {
  final basketController = Get.put(BasketScreenController());

  var productQuantity = double.parse(product.quantity).obs;
  var productImageUrl = localStorage.getitem(product.ean);
  return Container(
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      color: kWhite,
      elevation: 1,
      margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 18),
            child: productImageUrl != 'null'
                ? Image.network(
                    localStorage.getitem(product.ean),
                    width: 70,
                  )
                : Image.asset(
                    'images/imagineprodus.png',
                    width: 70,
                  ),
          ),
          Expanded(
            child: Column(
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        basketController.deleteProductAlert();
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.only(top: 10, right: 15),
                        child: Image.asset(
                          'images/eliminarexrosu.png',
                          width: 12,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(right: 30),
                      child: Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            product.price,
                            style: const TextStyle(
                              color: kBlue,
                            ),
                          ),
                          const Text(' lei'),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          children: [
                            BasketQuantitySelector(
                              quantity: productQuantity,
                              ean: product.ean,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
