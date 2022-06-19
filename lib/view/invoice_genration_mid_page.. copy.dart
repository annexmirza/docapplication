import 'package:docapplication/constants.dart';
import 'package:docapplication/controllers/conversion_controller.dart';
import 'package:docapplication/view/widgets/custom_button.dart';
import 'package:docapplication/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class InvoiceGenrationMidScreen extends StatelessWidget {
  ConversionController conversionController = Get.put(ConversionController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appdarkGreyColor,
          title: Text("Invoice"),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50.h),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 300.h,
                      // color: Colors.red,
                      width: 300.h,
                      child: SvgPicture.asset(
                        "assets/invoicei.svg",
                        semanticsLabel: 'A red up arrow',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 45.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomText(
                        titletext: "Welcome to Invoice",
                        fontsize: 35.sp,
                        color: appdarkGreyColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomText(
                        titletext: " Supplement your business information",
                        fontsize: 15.sp,
                        color: appdarkGreyColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomText(
                        titletext: "and start merchant invoice service",
                        fontsize: 15.sp,
                        color: appdarkGreyColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Divider(
                      color: Colors.white,
                      thickness: 2.h,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  customButton(
                      text: "Start",
                      height: 60.h,
                      width: 220.w,
                      color: appdarkGreyColor,
                      onTapFunction: () {
                        // conversionController.convertPPTToPdf();
                      },
                      radius: 10,
                      textSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
