import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfscancorafluttergetx/constants/colors.dart';
import 'package:selfscancorafluttergetx/models/product_model.dart';
import 'package:selfscancorafluttergetx/services/api.dart';

class PreviewBenefitsPopup extends StatelessWidget {
  RxInt cashDiscount = 0.obs;
  RxInt hyperPoints = 0.obs;
  RxDouble coraTickets = 0.0.obs;
  RxBool beneficiiCalculate = true.obs;

  List<ProductModel> productsList = <ProductModel>[];
  double totalPrice = 0;
  Function onDismiss = () => {};

  PreviewBenefitsPopup({
    required this.productsList,
    required this.totalPrice,
    required this.onDismiss,
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
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'images/popup-succes.png',
                        width: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                        child: Text(
                          'Pretul final la casa poate include reduceri suplimentare.',
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'images/popup-succes.png',
                        width: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                        child: Text(
                          'Pentru a afla ce beneficii sunt disponibile pentru produsele din cos, apasa \"Calculeaza beneficii\".',
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Obx(
                    () => cashDiscount.value > 0
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  '$cashDiscount Lei',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text('reduceri'),
                              ],
                            ),
                          )
                        : Container(),
                  ),
                  Obx(
                    () => coraTickets.value > 0
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  '$coraTickets Lei',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text('tichete Cora'),
                              ],
                            ),
                          )
                        : Container(),
                  ),
                  Obx(
                    () => hyperPoints.value > 0
                        ? Padding(
                            padding: const EdgeInsets.only(
                              bottom: 30,
                              top: 10,
                              left: 8,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '$hyperPoints.00',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 26,
                                ),
                                const Text(
                                  'hiperpuncte',
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ),
                  Obx(
                    () => beneficiiCalculate.value
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              width: 250,
                              height: 40,
                              child: ElevatedButton(
                                child: const Text('Calculeaza beneficii',
                                    style: TextStyle(fontSize: 18)),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(kBlue),
                                    foregroundColor:
                                        MaterialStateProperty.all(kWhite),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ))),
                                onPressed: () => {
                                  PreviewBenefits(
                                    totalPrice,
                                    productsList,
                                  ),
                                },
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 250,
                      height: 40,
                      child: ElevatedButton(
                        child: const Text("Anuleaza",
                            style: TextStyle(fontSize: 18)),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(kLightGrey),
                            foregroundColor: MaterialStateProperty.all(kBlack),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ))),
                        onPressed: () => {
                          onDismiss(),
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Future PreviewBenefits(double totalPrice, List productsList) async {
    var response = await getPreviewBenefits(totalPrice, productsList);

    cashDiscount.value = 0;
    coraTickets.value = 0;
    hyperPoints.value = 0;

    if (jsonDecode(response)["transactionSuccess"] != null) {
      cashDiscount.value =
          jsonDecode(response)["transactionSuccess"]["cashDiscount"];
      coraTickets.value =
          jsonDecode(response)["transactionSuccess"]["coraTickets"];
      hyperPoints.value =
          jsonDecode(response)["transactionSuccess"]["hyperPoints"];
    }

    print('lalala ${cashDiscount.value}');
    beneficiiCalculate.value = false;
  }
}
