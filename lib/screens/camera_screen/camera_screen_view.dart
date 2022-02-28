import 'package:fast_barcode_scanner/fast_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfscancorafluttergetx/screens/camera_screen/camera_screen_controller.dart';
import 'package:selfscancorafluttergetx/widgets/appbar/custom_appbar.dart';
import 'package:selfscancorafluttergetx/widgets/camera_bottom_container/camera_bottom_container.dart';
import 'package:selfscancorafluttergetx/widgets/pop_ups/camera_popup.dart';
import 'package:selfscancorafluttergetx/widgets/pop_ups/general_popup.dart';

class CameraScreen extends StatelessWidget {
  final cameraController = Get.put(CameraScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
      ),
      body: BarcodeCamera(
        types: const [
          BarcodeType.ean8,
          BarcodeType.ean13,
          BarcodeType.code128,
          BarcodeType.upcA,
          BarcodeType.upcE,
        ],
        resolution: Resolution.hd1080,
        framerate: Framerate.fps30,
        mode: DetectionMode.pauseVideo,
        onScan: (code) => cameraController.startScanning(code),
        children: [
          const MaterialPreviewOverlay(
            animateDetection: true,
            aspectRatio: 1 / 1,
          ),
          CustomAppBar(
            title: 'Scaneaza Produs',
            right: Container(),
          ),
          Obx(
            () => cameraController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                    ),
                  )
                : Container(),
          ),
          Obx(
            () => cameraController.showPopup.value
                ? CameraPopUp(
                    title: '${cameraController.title}',
                    price: '${cameraController.price}',
                    imageUrl:
                        'https://mcprod.cora.ro/${cameraController.imageURL}',
                    uom: '${cameraController.saleUnit}',
                    ean: '${cameraController.ean}',
                    restartScanning: cameraController.restartScanning,
                  )
                : Container(),
          ),
          Obx(
            () => cameraController.showError.value
                ? GeneralPopUp(
                    content:
                        "Acest produs poate fi scanat doar la casa de marcat",
                    showFunctionButton: false,
                    functionButtonText: '',
                    buttonFunction: () => {},
                    onDismiss: cameraController.restartScanning,
                  )
                : Container(),
          ),
          Obx(
            () => CameraBottomContainer(
              context,
              '${cameraController.nrProduse.value}',
              '${cameraController.pretTotal.value.toStringAsFixed(2)}',
            ),
          )
        ],
      ),
    );
  }
}
