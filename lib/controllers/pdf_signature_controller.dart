import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfSignatureController extends GetxController {
  final signaturePadKey = GlobalKey<SfSignaturePadState>();

  PdfDocument document = PdfDocument();

  File? loadedPdfFile;

  File? editedPdfFile;

  bool showSignaturePad = false;

  bool showLoadedPdf = false;

  bool showEditedPdf = false;

  var imageBitmap;

  double? screenCoordinateX;
  double? screenCoordinateY;

  showingLoadedPdf() {
    showLoadedPdf = true;
    update();
  }

  showingEditedPdf() {
    showEditedPdf = true;
    update();
  }

  hidingSignaturePad() {
    showSignaturePad = true;
    update();
  }

  submitingSignature() async {
    final image = await signaturePadKey.currentState!.toImage();
    final signatureImage = await image.toByteData(format: ImageByteFormat.png);
    imageBitmap = PdfBitmap(signatureImage!.buffer.asUint8List());
    update();
    hidingSignaturePad();
  }

  loadingPdf() async {
    ///picking files
    ///
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      loadedPdfFile = file;
      update();
      try {
        document = PdfDocument(inputBytes: File(file.path).readAsBytesSync());
        update();
        print('pdf loaded successfully');
      } catch (e) {
        print('error while loading pdf: $e');
      }
    } else {
      print('user did not select pdf file');
      // User canceled the picker
    }
  }

  editingPdf() {
    //Get the existing PDF page.
    final PdfPage page = document.pages[0];

//Draw text in the PDF page.

    final pageSize = page.getClientSize();

    try {
      page.graphics.drawImage(
          imageBitmap,
          Rect.fromLTWH((screenCoordinateX! * 2.393) - 100,
              screenCoordinateY! - 20, 200, 100));

      print('signature added');
      print(
          'pdf page height is ${pageSize.height} and width is ${pageSize.width}');

      update();
    } catch (e) {
      print('error in signature adding : $e');
    }
  }

  savingEditedPdf() async {
    try {
      Directory? appdir = await getExternalStorageDirectory();
      editedPdfFile = File('${appdir!.path}/output.pdf');
      update();
      File('${appdir.path}/output.pdf').writeAsBytes(document.save());

      print('file saved at : ${appdir.path}/output.pdf');
    } catch (e) {
      print('error while saving output : $e');
    }

//Dispose the document.
    //  document.dispose();
  }

  onTapDown(BuildContext context, TapDownDetails details) {
    // final RenderObject? box = context.findRenderObject();
    //inal Offset localOffset = box.globalToLocal(details.globalPosition);
    screenCoordinateX = details.localPosition.dx;
    update();
    screenCoordinateY = details.localPosition.dy;
    update();

    print(
        'Coordinates of touch is x: $screenCoordinateX and y: $screenCoordinateY');
  }
}
