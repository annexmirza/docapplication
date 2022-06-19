import 'package:docapplication/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  //  for Login
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  logIn() {
    APIServise apiServise = APIServise();
    LoginRequestModel requestModel = LoginRequestModel(
        email: emailController.text.trim(),
        password: passwordController.text.trim());

    apiServise.login(requestModel);

    // var res = CallApi.postData();
  }
}

class APIServise {
  login(LoginRequestModel requestModel) async {
    var url = Uri.parse("https://thevolunteerslab.com/docapp/api/v1/users");
    final responce = await http.post(url);
    print('myres' + responce.toString());
  }
}
