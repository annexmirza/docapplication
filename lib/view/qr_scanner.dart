import 'dart:ui';

import 'package:docapplication/constants.dart';
import 'package:docapplication/view/widgets/custom_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../controllers/qr_scanner_controller.dart';

class QRScannerPage extends StatelessWidget {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRScannerPage({Key? key}) : super(key: key);
  MobileScannerController cameraController = MobileScannerController();
  QRScannerController qrScannerController = Get.put(QRScannerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BarCode Scanner'),
          backgroundColor: appbkColor,
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state as TorchState) {
                    case TorchState.off:
                      return const Icon(Icons.flash_off, color: Colors.grey);
                    case TorchState.on:
                      return const Icon(Icons.flash_on, color: Colors.yellow);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.toggleTorch(),
            ),
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.cameraFacingState,
                builder: (context, state, child) {
                  switch (state as CameraFacing) {
                    case CameraFacing.front:
                      return const Icon(Icons.camera_front);
                    case CameraFacing.back:
                      return const Icon(Icons.camera_rear);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.switchCamera(),
            ),
          ],
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: Get.height / 1.3,
                  child: MobileScanner(
                      allowDuplicates: false,
                      controller: cameraController,
                      onDetect: (barcode, args) {
                        if (barcode.rawValue == null) {
                          debugPrint('Failed to scan Barcode');
                        } else {
                          qrScannerController.barCode = barcode.rawValue!;
                          qrScannerController.update();
                          debugPrint(
                              'Barcode found! $qrScannerController.barCode');

                          Text('Barcode found! $qrScannerController.barCode');
                        }
                        // code = barcode.rawValue;
                      }),
                ),
                Positioned(
                  top: 200,
                  left: 30,
                  right: 30,
                  child: CustomPaint(
                    painter: BorderPainter(),
                    child: Container(
                      width: 250.h,
                      height: 250.h,
                    ),
                  ),
                ),
              ],
            ),
            GetBuilder<QRScannerController>(builder: (qrScannerController) {
              return Column(
                children: [
                  CustomText(
                      titletext:
                          'Barcode found! ${qrScannerController.barCode}',
                      fontWeight: FontWeight.bold,
                      fontsize: 30,
                      color: Colors.black),
                  CustomText(
                      titletext: 'Place the Barcode inside the square ',
                      fontWeight: FontWeight.bold,
                      fontsize: 15,
                      color: Colors.black),
                ],
              );
            })
          ],
        ));
    // GetBuilder<QRScannerController>(
    //     init: QRScannerController(),
    //     builder: (qrScannerController) {
    //       // qrScannerController.reassembleQRController();
    //       return Scaffold(
    //         body: Column(
    //           children: <Widget>[
    //             Expanded(
    //               flex: 8,
    //               child: QRView(
    //                   key: qrKey,
    //                   onQRViewCreated: (QRViewController controller) {
    //                     qrScannerController.onQRViewCreated(controller);
    //                   }),
    //             ),
    //             Expanded(
    //                 flex: 1,
    //                 child: Center(
    //                   child: (qrScannerController.result != null)
    //                       ? Text(
    //                           'Barcode Type: ${describeEnum(qrScannerController.result!.format)}   Data: ${qrScannerController.result!.code}')
    //                       : Text('Scan a code'),
    //                 )),
    //             Expanded(
    //               flex: 1,
    //               child: ElevatedButton(
    //                 onPressed: () {
    //                   Get.back();
    //                 },
    //                 child: Text('Exit Scanner'),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     });
  }
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = 5.0;
    final radius = 20.0;
    final tRadius = 2 * radius;
    final rect = Rect.fromLTWH(
      width,
      width,
      size.width - 2 * width,
      size.height - 3 * width,
    );
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final clippingRect0 = Rect.fromLTWH(
      0,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect1 = Rect.fromLTWH(
      size.width - tRadius,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect2 = Rect.fromLTWH(
      0,
      size.height - tRadius,
      tRadius,
      tRadius,
    );
    final clippingRect3 = Rect.fromLTWH(
      size.width - tRadius,
      size.height - tRadius,
      tRadius,
      tRadius,
    );

    final path = Path()
      ..addRect(clippingRect0)
      ..addRect(clippingRect1)
      ..addRect(clippingRect2)
      ..addRect(clippingRect3);

    canvas.clipPath(path);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = width,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BarReaderSize {
  static double width = 200;
  static double height = 200;
}
