import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class ConversionController extends GetxController{


  getFile({required FileType fileType}) async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      type: fileType,
    );
    if (result != null) {
      var file = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }

}