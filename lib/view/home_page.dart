import 'package:docapplication/controllers/conversion_controller.dart';
import 'package:docapplication/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  ConversionController conversionController=Get.put(ConversionController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [customButton(text: " onpress "),
        customButton(text: " PDF to JPG ",onTapFunction: (){
          conversionController.convertPdfToJpg();
        }),
        customButton(text: " Docx to JPG ",onTapFunction: (){
          conversionController.convertDocxToJpg();
        }),
        customButton(text: " DOcx to PDF ",onTapFunction: (){
          conversionController.convertDocxToPdf();
        }),
        customButton(text: " DOcx to HTML ",onTapFunction: (){
          conversionController.convertDocxToHTML();
        }),
        customButton(text: " PPT to PDF ",onTapFunction: (){
          conversionController.convertPPTToPdf();
        }),
        customButton(text: " Excel to PDF ",onTapFunction: (){
          conversionController.convertExceltoPDF();
        }),
            customButton(text: " Image to PDF ",onTapFunction: (){
              conversionController.convertImageToPDF();
            }),
          
          ],
        ),
      ),
    );
  }
}
