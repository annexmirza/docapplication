import 'dart:io';
import 'dart:typed_data';

import 'package:docapplication/controllers/authentication_controller.dart';
import 'package:docapplication/model/file_model.dart';
import 'package:docapplication/services/api_service.dart';
import 'package:docapplication/view/all_file_viewer.dart';
import 'package:external_path/external_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:internet_file/internet_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class FileController extends GetxController {
  bool isLoading = false;
  AuthController authController = Get.put(AuthController());
  List myFiles = [];
  String selectedFileExtension = '';
  String filepath = '';
  String downloadPath = '';
  String fileName = '';
  String fileExtension = '';
  String path = '';
  List<FileModel> fileList = [];
  int totalFiles = 0;
  int currentDownloadingFile = 0;
  double progress = 0.0;
  setFileExtension(String extension) {
    selectedFileExtension = extension;
    update();
  }

  clearFileExtension() {
    selectedFileExtension = '';
  }

  openFile() async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx'],
    );
    setFilePath(filePickerResult!.files.first.path!);
  }

  downloadFile(String url) async {
    Directory directory = await getTemporaryDirectory();

    filepath = directory.path;
    String fileUrl = url;
    final File file = File(fileUrl);
    fileName = basenameWithoutExtension(file.path);
    fileExtension = extension(file.path);

    final Uint8List bytes = await InternetFile.get(
      fileUrl,
      process: (percentage) {
        update();

        print('downloadPercentage: $percentage');
      },
    );

    var file1 = await File('$filepath/$fileName' + '$fileExtension')
        .writeAsBytes(bytes);
    path = '$filepath/$fileName' + '$fileExtension';
    update();
    print(file1);
  }

  setFilePath(String path) {
    print("hang" + selectedFileExtension);
    // selectedFileExtension = fileExtension ?? '';
    downloadPath = path;
    update();
    Get.to(AllFileViewer());
  }

  getMyFiles() async {
    isLoading = true;
    fileList.clear();
    myFiles.clear();
    progress = 0.0;
    currentDownloadingFile = 1;
    totalFiles = 0;
    update();

    await authController.getUserData();
    ApiServices apiServices = ApiServices();
    await apiServices.getMyFiles(authController.user!.id!).then((value) {
      myFiles = value;
    });
    print(myFiles.length);
    await Future.forEach(myFiles, (dynamic element) async {
      currentDownloadingFile = myFiles.indexOf(element) + 1;

      await downloadFile(element['file_url']);
      fileList.add(FileModel.fromJson(
          {'name': fileName, 'path': path, 'extension': fileExtension}));
      progress = currentDownloadingFile / myFiles.length;
      update();
    });
    print(fileList.length);
    isLoading = false;
    update();
  }
}
