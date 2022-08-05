import 'package:docapplication/constants.dart';
import 'package:docapplication/view/camera_to_pdf_mid_page.dart';
import 'package:docapplication/view/excel_to_pdf_page.dart';
import 'package:docapplication/view/image_to_pdf_mid_page.dart';
import 'package:docapplication/view/pdf_signature.dart';
import 'package:docapplication/view/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/conversion_controller.dart';
import 'PPT_to_Pdf_mid_page...dart';
import 'invoice_genration_mid_page.. copy.dart';
import 'pdf_to_jpeg_mid_page.dart';
import 'Doc_to_Html_mid_page..dart';
import 'doc_to_jpeg_mid_page.dart';
import 'doc_to_pdf_mid_page.dart';
import 'quick_notes/notes_page.dart';
import 'widgets/file_iocn_container.dart';

class MoreScreen extends StatelessWidget {
  ConversionController conversionController = Get.put(ConversionController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'More',
          ),
          centerTitle: true,
          backgroundColor: Color(0xff111b21),
          elevation: 0,
          // give the app bar rounded corners
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(1.0),
              bottomRight: Radius.circular(1.0),
            ),
          ),
        ),
        backgroundColor: Color(0xff35343a),
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                " Common Functions",
                style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FileInfoContainer(
                  svgUrl: "assets/quicknotes.svg",
                  onTap: () {
                    Get.to(() => NotesPage());
                  },
                  title: "Quick Notes",
                ),
                FileInfoContainer(
                  svgUrl: "assets/pdftojpeg.svg",
                  onTap: () {
                    Get.to(() => PDFToJpegMidScreen());
                  },
                  title: "PDF to JPEG",
                ),
                FileInfoContainer(
                  svgUrl: "assets/docstojpeg.svg",
                  onTap: () {
                    Get.to(() => DocToJpegMidScreen());
                  },
                  title: "DOCS to JPEG",
                ),
                FileInfoContainer(
                  svgUrl: "assets/docstopdf.svg",
                  onTap: () {
                    Get.to(DoctoPdfmidScreen());
                  },
                  title: "DOCS to PDF",
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FileInfoContainer(
                    svgUrl: "assets/docstohtml.svg",
                    onTap: () {
                      Get.to(() => DoctoHtmlMidScreen());
                    },
                    title: "DOCS to HTML",
                  ),
                  FileInfoContainer(
                    svgUrl: "assets/exceltopdf.svg",
                    onTap: () {
                      Get.to(ExcelToPdfMidScreen());
                    },
                    title: "Excel to PDF",
                  ),
                  FileInfoContainer(
                    svgUrl: "assets/ppttopdf.svg",
                    onTap: () {
                      Get.to(() => PpttoPdfMidScreen());
                    },
                    title: "PPT to PDF",
                  ),
                  FileInfoContainer(
                    svgUrl: "assets/imagetopdf.svg",
                    onTap: () {
                      Get.to(() => ImagetoPdfMidScreen());

                      // print(" hhhhhhhhhhhhhhhhhhhhh");
                    },
                    title: "Image to PDF",
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FileInfoContainer(
                    svgUrl: "assets/cameratopdf.svg",
                    onTap: () {
                      Get.to(() => CameratoPdfMidScreen());
                    },
                    title: "Camera to PDF",
                  ),
                  FileInfoContainer(
                    svgUrl: "assets/qrscanner.svg",
                    onTap: () {
                      Get.to(() => QRScannerPage());
                    },
                    title: "QR Scanner",
                  ),
                  FileInfoContainer(
                    svgUrl: "assets/invoice.svg",
                    onTap: () {
                      Get.to(() => InvoiceGenrationMidScreen());
                    },
                    title: "invoice",
                  ),
                  FileInfoContainer(
                    svgUrl: "assets/resume.svg",
                    onTap: () {
                      Get.to(() => MoreScreen());
                      print(" hhhhhhhhhhhhhhhhhhhhh");
                    },
                    title: "Resume",
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 1.w, left: 18.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FileInfoContainer(
                    svgUrl: "assets/signature.svg",
                    onTap: () {
                      Get.to(() => PdfSignaturePage());
                    },
                    title: "Signature",
                  ),
                  // FileInfoContainer(
                  //   svgUrl: "assets/qrscanner.svg",
                  //   onTap: () {},
                  //   title: "PDF to JPEG",
                  // ),
                  // FileInfoContainer(
                  //   svgUrl: "assets/invoice.svg",
                  //   onTap: () {},
                  //   title: "PPT to PDF",
                  // ),
                  // SizedBox(
                  //   width: 10.w,
                  // ),
                  // FileInfoContainer(
                  //   svgUrl: "assets/resume.svg",
                  //   onTap: () {
                  //     Get.to(() => MoreScreen());
                  //     print(" hhhhhhhhhhhhhhhhhhhhh");
                  //   },
                  //   title: "More",
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
