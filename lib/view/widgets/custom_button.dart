import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

Widget customButton({
  onTapFunction,
  color = Colors.blue,
  double radius = 2,
  double height = 80,
  double width = 180,
  textColor = Colors.white,
  text = '',
  double textSize = 10,
  fontWeight = FontWeight.normal,
  Color borderColor = Colors.transparent,
}) {
  return InkWell(
    onTap: onTapFunction,
    child: Container(
        height: height.h,
        width: width.w,
        //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius.r),
          border: Border.all(color: borderColor, width: 1),
          color: color,
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: textSize.sp,
              fontWeight: fontWeight,
              color: textColor,
            ),
          ),
        )),
  );
}
