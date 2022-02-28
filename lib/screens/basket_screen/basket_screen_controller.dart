import 'package:get/get.dart';
import 'package:selfscancorafluttergetx/models/product_model.dart';
import 'package:selfscancorafluttergetx/services/products_list.dart';

class BasketScreenController extends GetxController {
  RxList<ProductModel> productsList = <ProductModel>[].obs;
  RxDouble totalPrice = 0.0.obs;
  RxBool showPopup = false.obs;
  RxBool deleteProductPopup = false.obs;
  RxBool clearBasketPopup = false.obs;
  RxBool previewBenefitsPopup = false.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getListOfProducts();
    super.onInit();
  }

  Future getListOfProducts() async {
    isLoading.value = true;
    await getProductList().then((value) {
      productsList.value = value;

      totalPrice.value = 0;
      for (var i in productsList) {
        var pretProdus = double.parse(i.price) * double.parse(i.quantity);
        totalPrice.value = totalPrice.value + pretProdus;
      }
    });
    isLoading.value = false;
  }

  void deleteProductAlert() {
    if (deleteProductPopup.value) {
      showPopup.value = false;
      deleteProductPopup.value = false;
    } else {
      showPopup.value = true;
      deleteProductPopup.value = true;
    }
  }

  void clearBasketAlert() {
    if (clearBasketPopup.value) {
      showPopup.value = false;
      clearBasketPopup.value = false;
    } else {
      showPopup.value = true;
      clearBasketPopup.value = true;
    }
  }

  void showBenefitsAlert() {
    if (previewBenefitsPopup.value) {
      showPopup.value = false;
      previewBenefitsPopup.value = false;
    } else {
      showPopup.value = true;
      previewBenefitsPopup.value = true;
    }
  }
}
