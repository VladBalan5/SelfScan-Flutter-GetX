import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfscancorafluttergetx/constants/colors.dart';
import 'package:selfscancorafluttergetx/screens/basket_screen/basket_screen_controller.dart';
import 'package:selfscancorafluttergetx/screens/basket_screen/empty_basket_screen.dart';
import 'package:selfscancorafluttergetx/screens/camera_screen/camera_screen_view.dart';
import 'package:selfscancorafluttergetx/services/api.dart';
import 'package:selfscancorafluttergetx/widgets/appbar/custom_appbar.dart';
import 'package:selfscancorafluttergetx/widgets/buttons/custom_button.dart';
import 'package:selfscancorafluttergetx/widgets/pop_ups/general_popup.dart';
import 'package:selfscancorafluttergetx/widgets/pop_ups/preview_benefits_popup.dart';
import 'package:selfscancorafluttergetx/widgets/product_card/product_card.dart';

class BasketScreen extends StatelessWidget {
  final basketController = Get.put(BasketScreenController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () => basketController.isLoading.value
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: kBackground,
                child: Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: const CircularProgressIndicator(
                      strokeWidth: 5,
                    ),
                  ),
                ),
              )
            : Container(
                child: basketController.productsList.isEmpty
                    ? EmptyBasketScreen()
                    : ProductsBasketScreen(),
              ),
      ),
    );
  }

  Scaffold ProductsBasketScreen() {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: kBackground,
      body: basketController.showPopup.value
          ? basketController.deleteProductPopup.value
              ? DeleteProductPopup()
              : basketController.previewBenefitsPopup.value
                  ? BenefitsPopup()
                  : ClearBasketPopup()
          : Container(
              color: kBackground,
              child: Column(
                children: [
                  CustomAppBar(
                    title: 'Cos cumparaturi',
                    right: GestureDetector(
                      onTap: () {
                        basketController.clearBasketAlert();
                      },
                      child: Image.asset('images/trashbutton.png'),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 20, left: 40, right: 40),
                    child: MaterialButton(
                      color: kBlue,
                      elevation: 0,
                      minWidth: 300,
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      onPressed: () {
                        basketController.showBenefitsAlert();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/whiteinfo.png',
                            width: 25,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Total estimativ: ',
                            style: TextStyle(
                              color: kWhite,
                              fontSize: 16,
                            ),
                          ),
                          Obx(
                            () => Text(
                              '${basketController.totalPrice.value.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: kWhite,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Text(
                            ' LEI',
                            style: TextStyle(
                              color: kWhite,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        itemCount: basketController.productsList.length,
                        itemBuilder: (context, index) {
                          return productCard(
                              basketController.productsList[index]);
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: CustomButton(
                      buttonHeight: 45,
                      buttonText: 'Scaneaza produs',
                      buttonFunction: () => {
                        Get.to(() => CameraScreen()),
                        basketController.getListOfProducts(),
                      },
                      buttonColor: kBlue,
                      buttonTextColor: kWhite,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 13, bottom: 13),
                    child: CustomButton(
                      buttonHeight: 45,
                      buttonText: 'Plateste cumparaturile',
                      buttonFunction: () => {},
                      buttonColor: kLightGrey,
                      buttonTextColor: kBlack,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  GeneralPopUp DeleteProductPopup() {
    return GeneralPopUp(
      content:
          'Esti sigur ca vrei sa stergi acest produs din cosul de cumparaturi?',
      showFunctionButton: true,
      functionButtonText: 'Elimina',
      buttonFunction: () => {
        basketController.deleteProductAlert(),
      },
      //buttonFunction: () => {updateSelfScanningProduct(, 0), basketController.deleteProductAlert(),},
      onDismiss: () => basketController.deleteProductAlert(),
    );
  }

  GeneralPopUp ClearBasketPopup() {
    return GeneralPopUp(
      content:
          'Esti sigur ca vrei sa stergi toate produsele din cosul de cumparaturi?',
      showFunctionButton: true,
      functionButtonText: 'Goleste cos',
      buttonFunction: () => {
        clearSelfScanningBasket(),
        basketController.getListOfProducts(),
        basketController.clearBasketAlert(),
      },
      onDismiss: () => basketController.clearBasketAlert(),
    );
  }

  PreviewBenefitsPopup BenefitsPopup() {
    return PreviewBenefitsPopup(
      productsList: basketController.productsList,
      totalPrice: basketController.totalPrice.value,
      onDismiss: () => basketController.showBenefitsAlert(),
    );
  }
}
