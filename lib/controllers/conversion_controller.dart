import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversionController extends GetxController{

  Future<File?> getFile({required FileType fileType}) async{
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowCompression: true,
        type: fileType,
      );
      if (result != null) {
        var file = File(result.files.single.path!);
        return file;
      }
      return null;
    }catch(e){
      Get.snackbar('Error', e.toString(),backgroundColor: Colors.black,colorText: Colors.white);
      return null;
    }
  }

}