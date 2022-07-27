import 'package:dio/dio.dart' as d;
import 'package:docapplication/model/user_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  uploadFile(List<PlatformFile> files) async {
    try {
      var dio = d.Dio();
      d.FormData formData = new d.FormData();
      formData.files.add(
          MapEntry("file", await d.MultipartFile.fromFile(files[0].path!)));
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

  login(String email, String password) async {
    var url =
        Uri.parse("https://thevolunteerslab.com/docapp/api/v1/users/login");
    final responce = await http.post(url, body: {
      'email': email,
      'password': password
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    Get.snackbar('Login', responce.body.toString());
    print('myres' + responce.statusCode.toString());
    print('myres' + responce.body.toString());
  }

  register(UserModel userModel) async {
    var url = Uri.parse("https://thevolunteerslab.com/docapp/api/v1/users");
    print(userModel.toJson());
    final responce = await http.post(url, body: userModel.toJson(), headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    Get.snackbar('Singup', responce.body.toString());
    print('myres' + responce.statusCode.toString());
    print('myres' + responce.body.toString());
  }
}
