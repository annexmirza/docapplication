import 'package:docapplication/controllers/color_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class FileInfoContainer extends StatelessWidget {
  ColorController colorController = Get.put(ColorController());
  VoidCallback onTap;
  String title;
  String svgUrl;
  FileInfoContainer(
      {required this.onTap, required this.title, required this.svgUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, top: 40.w),
      child: InkWell(
        onTap: onTap,
        child: GetBuilder<ColorController>(builder: (colorController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40.h,
                width: 40.h,
                child: SvgPicture.asset(
                  svgUrl,
                  semanticsLabel: 'A red up arrow',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                title,
                style: TextStyle(
                    color: !colorController.isSwitched
                        ? Colors.white
                        : Colors.black,
                    fontSize: 8.sp),
              )
            ],
          );
        }),
      ),
    );
  }
}
