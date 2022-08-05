import 'package:docapplication/constants.dart';
import 'package:docapplication/controllers/conversion_controller.dart';
import 'package:docapplication/view/widgets/custom_button.dart';
import 'package:docapplication/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CameratoPdfMidScreen extends StatelessWidget {
  ConversionController conversionController = Get.put(ConversionController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<ConversionController>(builder: (conversionController) {
          return conversionController.isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Container(
                      height: 250.h,
                      decoration: BoxDecoration(color: appGreenColor),
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 10.h),
                              child: CustomText(
                                  titletext: "Camera to PDF",
                                  fontsize: 30.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900)),
                          Padding(
                            padding: EdgeInsets.only(top: 50.h),
                            child: Container(
                              height: 200.h,
                              // color: Colors.red,
                              width: 150.h,
                              child: SvgPicture.asset(
                                "assets/DoctoJpegI.svg",
                                semanticsLabel: 'A red up arrow',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.h),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: CustomText(
                                  titletext: "Features",
                                  fontsize: 35.sp,
                                  color: appGreenColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20.w),
                                  child: Container(
                                    height: 10.h,
                                    width: 10.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 11.h,
                                ),
                                CustomText(
                                    titletext:
                                        '''After converting a PDF to Jpeg Document 
        you are free to Eidit the Document content''',
                                    fontsize: 15.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20.w),
                                  child: Container(
                                    height: 10.h,
                                    width: 10.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.h,
                                ),
                                CustomText(
                                    titletext:
                                        '''After converting a Doc to PDF Document 
        you are free to Eidit the Document content''',
                                    fontsize: 15.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: Divider(
                                color: Colors.white,
                                thickness: 2.h,
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(right: 17.w),
                                child: Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.w),
                                    color: Colors.white,
                                  ),
                                  width: 350.w,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            customButton(
                                text: "Selected Doc",
                                height: 60.h,
                                width: 220.w,
                                color: appGreenColor,
                                onTapFunction: () {
                                  conversionController.convertImageToPDF(
                                      imageFromCamera: true);
                                },
                                radius: 10,
                                textSize: 20.sp,
                                fontWeight: FontWeight.bold),
                            SizedBox(
                              height: Get.height / 32.5,
                            )
                          ],
                        ),
                      ),
                      color: Color(0xff35343a),
                      width: Get.width,
                      height: Get.height / 1.531,
                    ),
                  ],
                );
        }),
      ),
    );
  }
}
