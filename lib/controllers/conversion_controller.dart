import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:external_path/external_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_file/internet_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ConversionController extends GetxController{

  Future<File?> getFile({required List<String> fileTypes}) async{
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
    }catch(e){
      Get.snackbar('Error', e.toString(),backgroundColor: Colors.black,colorText: Colors.white);
      return null;
    }
  }

   convertImageToPDF() async {
    try {
      File? file = await getFile(fileTypes: ['png', 'jpg']);
      //Create the PDF document
      PdfDocument document = PdfDocument();
      //Add the page
      PdfPage page = document.pages.add();
      //Load the image.
      var data = file?.readAsBytesSync();
      String data2 = base64Encode(data!);
      final PdfImage image = PdfBitmap.fromBase64String(data2);
      //draw image to the first page
      page.graphics.drawImage(
          image, Rect.fromLTWH(0, 0, page.size.width, page.size.height));
      //Save the docuemnt
      List<int> bytes = document.save();
      String localPath = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      File saveFile = File('$localPath/Output.pdf');
//Write the PDF data
      if (await Permission.storage.request().isGranted) {
        await saveFile.writeAsBytes(bytes, flush: true);
      }
      //Dispose the document.
      document.dispose();
    }catch(e){
      Get.snackbar('Error', e.toString(),backgroundColor: Colors.black,colorText: Colors.white);
    }
  }


  convertPdfToJpg() async {
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
            print('downloadPercentage: $percentage');
          },
        );
        if(await Permission.storage.request().isGranted){
        var file1 = await File('${_localPath}/${abc['Files'][0]['FileName']}')
            .writeAsBytes(bytes);
        print(file1);
        }
        
      }
      Get.snackbar('Success', 'File converted successfully',
          colorText: Colors.white, backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }
  convertDocxToPdf() async {
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

       
        if(await Permission.storage.request().isGranted){
          HttpClient httpClient=HttpClient();
          var request = await httpClient.getUrl(Uri.parse(fileUrl));
  var response = await request.close();
  var bytes = await consolidateHttpClientResponseBytes(response);



        var file1 = await File('${_localPath}/${abc['Files'][0]['FileName']}')
            .writeAsBytes(bytes);
        print(file1);
        }
        
      }
      Get.snackbar('Success', 'File converted successfully',
          colorText: Colors.white, backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }
    convertDocxToJpg() async {
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
            print('downloadPercentage: $percentage');
          },
        );
        if(await Permission.storage.request().isGranted){
        var file1 = await File('${_localPath}/${abc['Files'][0]['FileName']}')
            .writeAsBytes(bytes);
        print(file1);
        }
        
      }
      Get.snackbar('Success', 'File converted successfully',
          colorText: Colors.white, backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }
  convertDocxToHTML() async {
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

        // final Uint8List bytes = await InternetFile.get(
        //   fileUrl,
        //   process: (percentage) {
        //     print('downloadPercentage: $percentage');
        //   },
        // );
        if(await Permission.storage.request().isGranted){
          HttpClient httpClient=HttpClient();
          var request = await httpClient.getUrl(Uri.parse(fileUrl));
  var response = await request.close();
  var bytes = await consolidateHttpClientResponseBytes(response);



        var file1 = await File('${_localPath}/${abc['Files'][0]['FileName']}')
            .writeAsBytes(bytes);
        print(file1);
        }
        
      }
      Get.snackbar('Success', 'File converted successfully',
          colorText: Colors.white, backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  convertPPTToPdf() async {
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

        // final Uint8List bytes = await InternetFile.get(
        //   fileUrl,
        //   process: (percentage) {
        //     print('downloadPercentage: $percentage');
        //   },
        // );
        if(await Permission.storage.request().isGranted){
          HttpClient httpClient=HttpClient();
          var request = await httpClient.getUrl(Uri.parse(fileUrl));
  var response = await request.close();
  var bytes = await consolidateHttpClientResponseBytes(response);



        var file1 = await File('${_localPath}/${abc['Files'][0]['FileName']}')
            .writeAsBytes(bytes);
        print(file1);
        }
        
      }
      Get.snackbar('Success', 'File converted successfully',
          colorText: Colors.white, backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  convertExceltoPDF() async {
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

        // final Uint8List bytes = await InternetFile.get(
        //   fileUrl,
        //   process: (percentage) {
        //     print('downloadPercentage: $percentage');
        //   },
        // );
        if(await Permission.storage.request().isGranted){
          HttpClient httpClient=HttpClient();
          var request = await httpClient.getUrl(Uri.parse(fileUrl));
  var response = await request.close();
  var bytes = await consolidateHttpClientResponseBytes(response);



        var file1 = await File('${_localPath}/${abc['Files'][0]['FileName']}')
            .writeAsBytes(bytes);
        print(file1);
        }
        
      }
      Get.snackbar('Success', 'File converted successfully',
          colorText: Colors.white, backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }
  
}
