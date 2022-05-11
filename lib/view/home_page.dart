import 'package:docapplication/controllers/conversion_controller.dart';
import 'package:docapplication/view/pdf_signature.dart';
import 'package:docapplication/view/quick_notes/notes_page.dart';
import 'package:docapplication/view/widgets/custom_button.dart';
import 'package:docapplication/view/widgets/file_iocn_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  ConversionController conversionController = Get.put(ConversionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: GetBuilder<ConversionController>(
                builder: (conversionController) {
              return conversionController.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FileInfoContainer(
                          svgUrl: "assets/quick notes.svg",
                          title: "kajhsdkaj",
                          onTap: () {
                            print("ontab Click");
                          },
                        ),
                        SizedBox(
                          height: 400,
                        ),
                        customButton(
                            text: " Quick notes ",
                            onTapFunction: () {
                              Get.to(() => NotesPage());
                            }),
                        SizedBox(
                          height: 10.h,
                        ),
                        customButton(
                            text: " PDF to JPG ",
                            onTapFunction: () {
                              conversionController.convertPdfToJpg();
                            }),
                        SizedBox(
                          height: 10.h,
                        ),
                        customButton(
                            text: " Docx to JPG ",
                            onTapFunction: () {
                              conversionController.convertDocxToJpg();
                            }),
                        SizedBox(
                          height: 10.h,
                        ),
                        customButton(
                            text: " DOcx to PDF ",
                            onTapFunction: () {
                              conversionController.convertDocxToPdf();
                            }),
                        SizedBox(
                          height: 10.h,
                        ),
                        customButton(
                            text: " DOcx to HTML ",
                            onTapFunction: () {
                              conversionController.convertDocxToHTML();
                            }),
                        SizedBox(
                          height: 10.h,
                        ),
                        customButton(
                            text: " PPT to PDF ",
                            onTapFunction: () {
                              conversionController.convertPPTToPdf();
                            }),
                        SizedBox(
                          height: 10.h,
                        ),
                        customButton(
                            text: " Excel to PDF ",
                            onTapFunction: () {
                              conversionController.convertExceltoPDF();
                            }),
                        SizedBox(
                          height: 10.h,
                        ),
                        customButton(
                            text: " Image to PDF ",
                            onTapFunction: () {
                              conversionController.convertImageToPDF(
                                  imageFromCamera: false);
                            }),
                        SizedBox(
                          height: 10.h,
                        ),
                        customButton(
                            text: "Image From Camera to PDF ",
                            onTapFunction: () {
                              conversionController.convertImageToPDF(
                                  imageFromCamera: true);
                            }),
                        SizedBox(
                          height: 10.h,
                        ),
                        customButton(
                            text: "Signature",
                            onTapFunction: () {
                              Get.to(() => PdfSignaturePage());
                            }),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    );
            }),
          ),
        ),
      ),
    );
  }
}
