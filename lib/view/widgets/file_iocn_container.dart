import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FileInfoContainer extends StatelessWidget {
  Function onTap;
  String title;
  String svgUrl;
  FileInfoContainer(
      {required this.onTap, required this.title, required this.svgUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, top: 40.w),
      child: Column(
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
            style: TextStyle(color: Colors.white, fontSize: 8.sp),
          )
        ],
      ),
    );
  }
}
