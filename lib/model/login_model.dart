import 'dart:convert';

class LoginResponceModel {
  final String? token;
  final String? error;

  LoginResponceModel({this.token, this.error});
  factory LoginResponceModel.fromjson(Map<String, dynamic> json) {
    return LoginResponceModel(
        token: json["token"] != null ? json["token"] : "",
        error: json["error"] != null ? json["error"] : "");
  }
}

class LoginRequestModel {
  String? email;
  String? password;
  LoginRequestModel({this.email, this.password});
  Map<String, dynamic> tojson() {
    return {"email": email, "password": password};
  }
}
