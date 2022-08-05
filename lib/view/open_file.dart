import 'package:docapplication/controllers/file_controller.dart';
import 'package:docapplication/view/all_file_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_view/flutter_file_view.dart';
import 'package:get/get.dart';

class OpenFileScreen extends StatelessWidget {
  OpenFileScreen({Key? key}) : super(key: key);
  FileController fileController = Get.put(FileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: GetBuilder<FileController>(builder: (fileController) {
        return Center(
          child: InkWell(
            child: Text('Hello World'),
            onTap: () {},
          ),
        );
      }),
    ));
  }
}
