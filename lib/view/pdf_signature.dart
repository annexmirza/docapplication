import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../controllers/pdf_signature_controller.dart';

class PdfSignaturePage extends StatelessWidget {
  PdfSignaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PdfSignatureController>(
        init: PdfSignatureController(),
        builder: (pdfSignatureController) {
          return Scaffold(
            body: pdfSignatureController.showEditedPdf
                ? PDFView(
                    filePath: pdfSignatureController.editedPdfFile!.path,
                  )
                // PDFView(
                //     filePath: pdfSignatureController.editedPdfFile!.path,
                //   )

                : pdfSignatureController.showLoadedPdf
                    ? GestureDetector(
                        onTapDown: (TapDownDetails details) async {
                          pdfSignatureController.onTapDown(context, details);

                          await pdfSignatureController.editingPdf();
                          await pdfSignatureController.savingEditedPdf();
                          await pdfSignatureController.showingEditedPdf();
                        },
                        child: PDFView(
                          filePath: pdfSignatureController.loadedPdfFile!.path,
                        ),
                      )
                    //  Builder(builder: (BuildContext context1) {
                    //     return GestureDetector(
                    //       onTapDown: (TapDownDetails details) async {
                    //         pdfSignatureController.onTapDown(context1, details);

                    //         await pdfSignatureController.editingPdf();
                    //         await pdfSignatureController.savingEditedPdf();
                    //         await pdfSignatureController.showingEditedPdf();
                    //       },
                    //       child: PDFView(
                    //         filePath:
                    //             pdfSignatureController.loadedPdfFile!.path,
                    //       ),
                    //     );
                    //   },)
                    : pdfSignatureController.showSignaturePad
                        ? InkWell(
                            onTap: () async {
                              await pdfSignatureController.loadingPdf();

                              pdfSignatureController.showingLoadedPdf();
                              Get.snackbar('successfull', 'mission complete');

                              //   pdfSignatureController.hidingSignaturePad();
                            },
                            child: Center(
                              child: Container(
                                height: 80.h,
                                width: 250.w,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[900],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Click here to Load pdf',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Container(
                                height: Get.height / 1.2,
                                child: SfSignaturePad(
                                  key: pdfSignatureController.signaturePadKey,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  //add signature to pdf functiuon
                                  await pdfSignatureController
                                      .submitingSignature();
                                },
                                child: Text('Add signature'),
                              ),
                            ],
                          ),
          );
        });
  }
}
