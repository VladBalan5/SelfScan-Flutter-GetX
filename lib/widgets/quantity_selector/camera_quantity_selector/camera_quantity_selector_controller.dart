import 'package:get/get.dart';

class CameraQuantitySelectorController extends GetxController {
  RxInt quantity = 1.obs;

  void increase() {
    if (quantity < 999) quantity++;
  }

  void decrease() {
    if (quantity > 1) quantity--;
  }
}
