import 'package:docapplication/controllers/authentication_controller.dart';
import 'package:docapplication/view/authentication/login_page.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../widgets/custom_text_field.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Text(
              'Wps name of App',
              style: TextStyle(
                  color: appDarkBlueColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            )),
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Sign up',
              style: TextStyle(fontSize: 20),
            )),
        Container(
          padding: const EdgeInsets.all(10),
          child: Customtextfield(
            lableName: "name",
            textEditingController: authController.nameController,
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Customtextfield(
            lableName: "email",
            textEditingController: authController.emailController,
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Customtextfield(
            lableName: " Password",
            textEditingController: authController.passwordController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            child: DropdownSearch<String>(
              popupProps: PopupProps.menu(
                showSearchBox: false,
                showSelectedItems: true,
                disabledItemFn: (String s) => s.startsWith('I'),
              ),
              items: [
                "Male",
                "Female ",
              ],
              // dropdownSearchDecoration:  const InputDecoration(
              //     labelText: "Menu mode",
              //     hintText: "country in menu mode",
              // ),
              onChanged: (value) {
                authController.gender = value!;
                authController.update();
              },
              selectedItem: "---Selected Gender---",
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            //forgot password screen
          },
          child: const Text(
            'Forgot Password',
          ),
        ),
        Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('Sign up'),
              onPressed: () {
                authController.register();
                // print(nameController.text);
                // print(passwordController.text);
              },
            )),
        Row(
          children: <Widget>[
            const Text('I have account?'),
            TextButton(
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Get.to(() => LoginPage());
              },
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ],
    ));
  }
}
