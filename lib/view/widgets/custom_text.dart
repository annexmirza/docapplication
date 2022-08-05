import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  String titletext = "";
  Color? color = Colors.red;
  FontWeight? fontWeight = FontWeight.bold;
  double? fontsize = 20.sp;

  CustomText(
      {required this.titletext, this.color, this.fontWeight, this.fontsize});

  @override
  Widget build(BuildContext context) {
    return Text(
      titletext,
      maxLines: 10,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.comicNeue(
          textStyle: TextStyle(
              color: color, fontSize: fontsize, fontWeight: fontWeight)),
    );
  }
}
