import 'dart:io';

import 'package:docapplication/controllers/file_controller.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_file_view/flutter_file_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:path_provider/path_provider.dart';

class ImageView extends StatelessWidget {
  ImageView({Key? key}) : super(key: key);
  FileController fileController = Get.put(FileController());
  @override
  Widget build(BuildContext context) {
    // fileController.getFileDirectory();
    return Scaffold(
      appBar: AppBar(
        title: Text('File Viewer'),
      ),
      body: SafeArea(
        child: GetBuilder<FileController>(builder: (controller) {
          return Column(
            children: [
              // fileController.selectedFileExtension == '.jpg'
              //     ?
              //
              Image.file(File(fileController.downloadPath))

              //     :
              // Container(
              //     height: Get.height - 100,
              //     width: Get.width,
              //     child: LocalFileViewer(filePath: controller.downloadPath))
            ],
          );
        }),
      ),
    );
  }
}
