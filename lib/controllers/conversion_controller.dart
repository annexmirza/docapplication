import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:docapplication/controllers/authentication_controller.dart';
import 'package:external_path/external_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:internet_file/internet_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path/path.dart' as path;

class ConversionController extends GetxController {
  AuthController authController = Get.put(AuthController());
  bool isLoading = false;
  double percent = 0.0;

  Future<File?> getFile({required List<String> fileTypes}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowCompression: true,
        type: FileType.custom,
        allowedExtensions: fileTypes,
      );
      if (result != null) {
        var file = File(result.files.single.path!);
        return file;
      }
      return null;
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.black, colorText: Colors.white);
      return null;
    }
  }

  Future<File?> getImageFromCamera() async {
    try {
      final XFile? xFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (xFile != null) {
        File file = File(xFile.path);
        return file;
      }
      return null;
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.black, colorText: Colors.white);
      return null;
    }
  }

  convertImageToPDF({required bool imageFromCamera}) async {
    isLoading = true;
    update();
    try {
      File? file;
      String? fileName;
      if (imageFromCamera) {
        file = await getImageFromCamera();
        isLoading = true;
      } else {
        file = await getFile(fileTypes: ['png', 'jpg']);
      }
      if (file != null) {
        fileName = path.basenameWithoutExtension(file.path);
        PdfDocument document = PdfDocument();
        PdfPage page = document.pages.add();
        var data = file.readAsBytesSync();
        String data2 = base64Encode(data);
        final PdfImage image = PdfBitmap.fromBase64String(data2);
        page.graphics.drawImage(
            image, Rect.fromLTWH(0, 0, page.size.width, page.size.height));
        List<int> bytes = await document.save();
        String localPath = await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOADS);
        File saveFile = File('$localPath/$fileName.pdf');
        if (await Permission.storage.request().isGranted) {
          await saveFile.writeAsBytes(bytes, flush: true);
          authController.uploadFile(saveFile);
          isLoading = false;
        }
        document.dispose();
      } else {
        Get.snackbar('Error', 'No File Selected',
            backgroundColor: Colors.black, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.black, colorText: Colors.white);
    }
    isLoading = false;
    update();
  }

  convertPdfToJpg() async {
    isLoading = true;

    update();

    try {
      String _localPath = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);

      String url =
          'https://v2.convertapi.com/convert/pdf/to/jpg?Secret=LN72qmLNad8Jwa8J';
      var filePickerResult = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      isLoading = true;
      update();
      if (filePickerResult != null) {
        File file = File(filePickerResult.files.single.path!);

        String filePath = file.path;
        String fileName = file.path.split('/').last;
        Uint8List? fileInBytes = file.readAsBytesSync();
        String? docFileData = base64Encode(fileInBytes);
        final body = {
          "Parameters": [
            {
              "Name": "File",
              "FileValue": {"Name": fileName, "Data": docFileData}
            },
            {"Name": "StoreFile", "Value": true}
          ]
        };

        http.Response response = await http.post(Uri.parse(url),
            body: jsonEncode(body),
            headers: {"Content-Type": "application/json"});
        print(response.body);
        var abc = jsonDecode(response.body);
        String fileUrl = abc['Files'][0]['Url'];

        final Uint8List bytes = await InternetFile.get(
          fileUrl,
          process: (percentage) {
            percent = percentage;
            update();

            print('downloadPercentage: $percentage');
          },
        );
        if (await Permission.storage.request().isGranted) {
          var file1 = await File('${_localPath}/${abc['Files'][0]['FileName']}')
              .writeAsBytes(bytes);
          authController.uploadFile(file1);
          print(file1);
        }
      }

      Get.snackbar('Success', 'File converted successfully',
          colorText: Colors.white, backgroundColor: Colors.green);
      isLoading = false;
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
    isLoading = false;
    update();
  }

  convertDocxToPdf() async {
    percent = 0.0;
    update();
    isLoading = true;
    update();
    try {
      String _localPath = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      String url =
          'https://v2.convertapi.com/convert/docx/to/pdf?Secret=LN72qmLNad8Jwa8J';
      var filePickerResult = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['docx'],
      );
      isLoading = true;
      if (filePickerResult != null) {
        File file = File(filePickerResult.files.single.path!);
        String filePath = file.path;
        String fileName = file.path.split('/').last;
        Uint8List? fileInBytes = file.readAsBytesSync();
        String? docFileData = base64Encode(fileInBytes);
        final body = {
          "Parameters": [
            {
              "Name": "File",
              "FileValue": {"Name": fileName, "Data": docFileData}
            },
            {"Name": "StoreFile", "Value": true}
          ]
        };

        http.Response response = await http.post(Uri.parse(url),
            body: jsonEncode(body),
            headers: {"Content-Type": "application/json"});
        print(response.body);
        var abc = jsonDecode(response.body);
        String fileUrl = abc['Files'][0]['Url'];

        if (await Permission.storage.request().isGranted) {
          HttpClient httpClient = HttpClient();
          var request = await httpClient.getUrl(Uri.parse(fileUrl));
          var response = await request.close();
          var bytes = await consolidateHttpClientResponseBytes(response);

          var file1 = await File('${_localPath}/${abc['Files'][0]['FileName']}')
              .writeAsBytes(bytes);
          authController.uploadFile(file1);
          print(file1);
        }
      }
      Get.snackbar('Success', 'File converted successfully',
          colorText: Colors.white, backgroundColor: Colors.green);
      isLoading = false;
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
    isLoading = false;
    update();
  }

  convertDocxToJpg() async {
    percent = 0.0;
    isLoading = true;
    update();
    try {
      String _localPath = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      String url =
          'https://v2.convertapi.com/convert/docx/to/jpg?Secret=LN72qmLNad8Jwa8J';
      var filePickerResult = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['docx'],
      );
      isLoading = true;
      if (filePickerResult != null) {
        File file = File(filePickerResult.files.single.path!);
        String filePath = file.path;
        String fileName = file.path.split('/').last;
        Uint8List? fileInBytes = file.readAsBytesSync();
        String? docFileData = base64Encode(fileInBytes);
        final body = {
          "Parameters": [
            {
              "Name": "File",
              "FileValue": {"Name": fileName, "Data": docFileData}
            },
            {"Name": "StoreFile", "Value": true}
          ]
        };

        http.Response response = await http.post(Uri.parse(url),
            body: jsonEncode(body),
            headers: {"Content-Type": "application/json"});
        print(response.body);
        var abc = jsonDecode(response.body);
        String fileUrl = abc['Files'][0]['Url'];

        final Uint8List bytes = await InternetFile.get(
          fileUrl,
          process: (percentage) {
            percent = percentage / 100;
            update();

            print('downloadPercentage: $percentage');
          },
        );
        if (await Permission.storage.request().isGranted) {
          var file1 = await File('${_localPath}/${abc['Files'][0]['FileName']}')
              .writeAsBytes(bytes);
          authController.uploadFile(file1);
          print(file1);
        }
      }
      Get.snackbar('Success', 'File converted successfully',
          colorText: Colors.white, backgroundColor: Colors.green);
      isLoading = false;
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
    isLoading = false;
    update();
  }

  convertDocxToHTML() async {
    isLoading = true;
    update();
    try {
      String _localPath = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      String url =
          'https://v2.convertapi.com/convert/docx/to/html?Secret=LN72qmLNad8Jwa8J';
      var filePickerResult = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['docx'],
      );
      isLoading = true;

      if (filePickerResult != null) {
        File file = File(filePickerResult.files.single.path!);
        String filePath = file.path;
        String fileName = file.path.split('/').last;
        Uint8List? fileInBytes = file.readAsBytesSync();
        String? docFileData = base64Encode(fileInBytes);
        final body = {
          "Parameters": [
            {
              "Name": "File",
              "FileValue": {"Name": fileName, "Data": docFileData}
            },
            {"Name": "StoreFile", "Value": true}
          ]
        };

        http.Response response = await http.post(Uri.parse(url),
            body: jsonEncode(body),
            headers: {"Content-Type": "application/json"});
        print(response.body);
        var abc = jsonDecode(response.body);
        String fileUrl = abc['Files'][0]['Url'];

        final Uint8List bytes = await InternetFile.get(
          fileUrl,
          process: (percentage) {
            percent = percentage;
            update();

            print('downloadPercentage: $percentage');
          },
        );
        if (await Permission.storage.request().isGranted) {
          HttpClient httpClient = HttpClient();
          var request = await httpClient.getUrl(Uri.parse(fileUrl));
          var response = await request.close();
          var bytes = await consolidateHttpClientResponseBytes(response);

          var file1 = await File('${_localPath}/${abc['Files'][0]['FileName']}')
              .writeAsBytes(bytes);
          authController.uploadFile(file1);
          print(file1);
        }
      }
      Get.snackbar('Success', 'File converted successfully',
          colorText: Colors.white, backgroundColor: Colors.green);
      isLoading = false;
    } catch (e) {
      Get.snackbar('Errorrrrrr', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
    isLoading = false;
    update();
  }

  convertPPTToPdf() async {
    isLoading = true;
    update();
    try {
      String _localPath = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      String url =
          'https://v2.convertapi.com/convert/ppt/to/pdf?Secret=LN72qmLNad8Jwa8J';
      var filePickerResult = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['ppt'],
      );
      isLoading = true;
      if (filePickerResult != null) {
        File file = File(filePickerResult.files.single.path!);
        String filePath = file.path;
        String fileName = file.path.split('/').last;
        Uint8List? fileInBytes = file.readAsBytesSync();
        String? docFileData = base64Encode(fileInBytes);
        final body = {
          "Parameters": [
            {
              "Name": "File",
              "FileValue": {"Name": fileName, "Data": docFileData}
            },
            {"Name": "StoreFile", "Value": true}
          ]
        };

        http.Response response = await http.post(Uri.parse(url),
            body: jsonEncode(body),
            headers: {"Content-Type": "application/json"});
        print(response.body);
        var abc = jsonDecode(response.body);
        String fileUrl = abc['Files'][0]['Url'];

        final Uint8List bytes = await InternetFile.get(
          fileUrl,
          process: (percentage) {
            percent = percentage;
            update();

            print('downloadPercentage: $percentage');
          },
        );
        if (await Permission.storage.request().isGranted) {
          HttpClient httpClient = HttpClient();
          var request = await httpClient.getUrl(Uri.parse(fileUrl));
          var response = await request.close();
          var bytes = await consolidateHttpClientResponseBytes(response);

          var file1 = await File('${_localPath}/${abc['Files'][0]['FileName']}')
              .writeAsBytes(bytes);
          authController.uploadFile(file1);
          print(file1);
        }
      }
      Get.snackbar('Success', 'File converted successfully',
          colorText: Colors.white, backgroundColor: Colors.green);
      isLoading = false;
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
    isLoading = false;
    update();
  }

  convertExceltoPDF() async {
    isLoading = true;
    update();
    try {
      String _localPath = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      String url =
          'https://v2.convertapi.com/convert/xlsx/to/pdf?Secret=LN72qmLNad8Jwa8J';
      var filePickerResult = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );
      isLoading = true;
      if (filePickerResult != null) {
        File file = File(filePickerResult.files.single.path!);
        String filePath = file.path;
        String fileName = file.path.split('/').last;
        Uint8List? fileInBytes = file.readAsBytesSync();
        String? docFileData = base64Encode(fileInBytes);
        final body = {
          "Parameters": [
            {
              "Name": "File",
              "FileValue": {"Name": fileName, "Data": docFileData}
            },
            {"Name": "StoreFile", "Value": true}
          ]
        };

        http.Response response = await http.post(Uri.parse(url),
            body: jsonEncode(body),
            headers: {"Content-Type": "application/json"});
        print(response.body);
        var abc = jsonDecode(response.body);
        String fileUrl = abc['Files'][0]['Url'];

        final Uint8List bytes = await InternetFile.get(
          fileUrl,
          process: (percentage) {
            percent = percentage;
            update();

            print('downloadPercentage: $percentage');
          },
        );
        if (await Permission.storage.request().isGranted) {
          HttpClient httpClient = HttpClient();
          var request = await httpClient.getUrl(Uri.parse(fileUrl));
          var response = await request.close();
          var bytes = await consolidateHttpClientResponseBytes(response);

          var file1 = await File('${_localPath}/${abc['Files'][0]['FileName']}')
              .writeAsBytes(bytes);
          authController.uploadFile(file1);
          print(file1);
        }
      }
      Get.snackbar('Success', 'File converted successfully',
          colorText: Colors.white, backgroundColor: Colors.green);
      isLoading = false;
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
    isLoading = false;
    update();
  }
}
