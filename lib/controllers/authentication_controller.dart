import 'dart:io';

import 'package:docapplication/model/user_model.dart';
import 'package:docapplication/services/api_service.dart';
import 'package:docapplication/view/home_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
// import 'package:dio/dio.dart';

class AuthController extends GetxController {
  //  for Login

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String gender = "";

  logIn() {
    ApiServices apiService = ApiServices();

    apiService.login(
        emailController.text.trim(), passwordController.text.trim());

    // var res = CallApi.postData();
  }

  register() {
    Uuid uuid = Uuid();
    String id = uuid.v4();
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      id: id,
      profilePic: "",
      gender: gender,
    );
    ApiServices apiServices = ApiServices();
    apiServices.register(userModel);
  }

  uploadFile() async {
    FilePickerResult? file =
        await FilePicker.platform.pickFiles(type: FileType.any);
    ApiServices apiServices = ApiServices();
    apiServices.uploadFile(file!.files);
  }
}
