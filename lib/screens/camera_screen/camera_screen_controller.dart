import 'dart:convert';

import 'package:fast_barcode_scanner/fast_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:selfscancorafluttergetx/models/product_model.dart';
import 'package:selfscancorafluttergetx/services/api.dart';
import 'package:selfscancorafluttergetx/services/products_list.dart';

class CameraScreenController extends GetxController {
  RxString ean = ''.obs;
  RxString title = ''.obs;
  RxString price = ''.obs;
  RxString imageURL = ''.obs;
  RxString saleUnit = ''.obs;
  RxBool showPopup = false.obs;
  RxBool showError = false.obs;
  RxBool isLoading = false.obs;
  RxList<ProductModel> productsList = <ProductModel>[].obs;
  RxDouble pretTotal = 0.0.obs;
  RxInt nrProduse = 0.obs;

  @override
  void onInit() {
    _checkPermission();
    getNrProductsAndPrice();
    super.onInit();
  }

  Future _checkPermission() async {
    var status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      print('Permission granted');
      CameraController.instance.resumeDetector();
    } else if (status == PermissionStatus.denied) {
      Permission.camera.request();
      print(
          'Permission denied. Show a dialog and again ask for the permission');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
      await openAppSettings();
    }
  }

  Future getNrProductsAndPrice() async {
    nrProduse.value = 0;
    pretTotal.value = 0;

    await getProductList().then((value) {
      productsList.value = value;

      for (var i in productsList) {
        var pretProdus = double.parse(i.price) * double.parse(i.quantity);
        pretTotal.value = pretTotal.value + pretProdus;
        nrProduse.value = (nrProduse.value + double.parse(i.quantity)).round();
      }
    });
  }

  Future getProductDetailsSelfScan(String? ean) async {
    isLoading.value = true;

    var response = await getProductDetails(ean);
    if (jsonDecode(response)["transactionSuccess"] != null) {
      var productTitle =
          jsonDecode(response)["transactionSuccess"]["product"]["title"];
      var productImage =
          jsonDecode(response)["transactionSuccess"]["product"]["imageURL"];
      var productPrice = jsonDecode(response)["transactionSuccess"]["product"]
              ["newPrice"]
          .toString();
      var productSaleUnit =
          jsonDecode(response)["transactionSuccess"]["product"]["saleUnit"];

      isLoading.value = false;
      title.value = productTitle;
      imageURL.value = productImage;
      price.value = productPrice;
      saleUnit.value = productSaleUnit;
      showPopup.value = true;
    } else {
      isLoading.value = false;
      showError.value = true;
      return null;
    }
  }

  void restartScanning() {
    CameraController.instance.resumeDetector();
    showPopup.value = false;
    showError.value = false;
  }

  void startScanning(code) async {
    await getProductDetailsSelfScan(code.value);
    ean.value = code.value;
  }
}
