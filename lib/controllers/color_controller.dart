import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ColorController extends GetxController {
  bool isSwitched = false;
  static bool staticSwitch = false;
  String textValue = 'Switch is OFF';
  String theme = "Dark Mode";
  var themeIcon = Icons.dark_mode_outlined;

/* ---------------------------------- Lists --------------------------------- */

/* -------------------------------- Functions ------------------------------- */

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      isSwitched = true;
      staticSwitch = true;
      themeIcon = Icons.light_mode_outlined;
      Get.changeTheme(ThemeData.light());
      GetStorage().write('isSwitched', isSwitched);
      theme = "Light Mode";
      textValue = 'Switch Button is OFF';
    } else {
      theme = "Dark Mode";
      Get.changeTheme(ThemeData.dark());
      isSwitched = false;
      staticSwitch = false;
      GetStorage().write('isSwitched', isSwitched);
      textValue = 'Switch Button is ON';
      themeIcon = Icons.dark_mode_outlined;
    }
    update();
  }
}





















//   bool isSwitched = false;
//   static bool staticSwitch = false;
//   String textValue = 'Switch is OFF';
//   String theme = "Dark Mode";
//   var themeIcon = Icons.dark_mode_outlined;

// /* ---------------------------------- Lists --------------------------------- */

// /* -------------------------------- Functions ------------------------------- */

//   void toggleSwitch(bool value) {
//     if (isSwitched == false) {
//       isSwitched = true;
//       staticSwitch = true;
//       themeIcon = Icons.light_mode_outlined;
//       Get.changeTheme(ThemeData.light());
//       GetStorage().write('isSwitched', isSwitched);
//       theme = "Light Mode";
//       textValue = 'Switch Button is OFF';
//     } else {
//       theme = "Dark Mode";
//       Get.changeTheme(ThemeData.dark());
//       isSwitched = false;
//       staticSwitch = false;
//       GetStorage().write('isSwitched', isSwitched);
//       textValue = 'Switch Button is ON';
//       themeIcon = Icons.dark_mode_outlined;
//     }
//     update();


