import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:docapplication/model/user_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  uploadFile(File file, String userId) async {
    try {
      var dio = d.Dio();
      d.FormData formData = new d.FormData();
      formData.files
          .add(MapEntry("file", await d.MultipartFile.fromFile(file.path)));
      formData.fields.add(MapEntry("userId", userId));
      var url = "https://thevolunteerslab.com/docapp/api/v1/users/uploadfile";
      dio
          .post(url,
              data: formData,
              options: d.Options(
                  method: 'POST',
                  responseType: d.ResponseType.plain // or ResponseType.JSON
                  ))
          .then((response) => print(response.data))
          .catchError((error) => print(error));
    } catch (e) {
      print(e);
    }
  }

  dynamic login(String email, String password) async {
    var url =
        Uri.parse("https://thevolunteerslab.com/docapp/api/v1/users/login");
    final responce = await http.post(url, body: {
      'email': email,
      'password': password
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    return json.decode(responce.body);
  }

  register(UserModel userModel) async {
    var url = Uri.parse("https://thevolunteerslab.com/docapp/api/v1/users");
    print(userModel.toJson());
    final responce = await http.post(url, body: userModel.toJson(), headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    var body = jsonDecode(responce.body);
    Get.snackbar('Singup', body['sqlMessage'].toString());
    print('myres' + responce.statusCode.toString());
    print('myres' + responce.body.toString());
  }

  getMyFiles(String id) async {
    var url = Uri.parse("https://thevolunteerslab.com/docapp/getfiles/$id");
    final responce = await http.get(url, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    return json.decode(responce.body);
  }
}
