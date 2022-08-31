import 'package:docapplication/controllers/authentication_controller.dart';
import 'package:docapplication/view/all_file_viewer.dart';
import 'package:docapplication/view/invoice_genration_mid_page..%20copy.dart';
import 'package:docapplication/view/nav_tab.dart';
// import 'package:docapplication/view/open_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_file_view/flutter_file_view.dart';
// import 'package:flutter_file_view/flutter_file_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:power_file_view/power_file_view.dart';

import 'view/authentication/login_page.dart';
import 'view/doc_to_pdf_mid_page.dart';
import 'view/authentication/login_page.dart';
import 'view/doc_to_pdf_mid_page.dart';
import 'view/home_page.dart';
import 'view/home_tab_page.dart';
import 'view/home_tab_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // PowerFileViewManager.initEngine();
  // await Firebase.initializeApp(
  //     // options: DefaultFirebaseOptions.currentPlatform
  //     );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState() {}
  @override
  Widget build(BuildContext context) {
    // authController.getUserData();
    return ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (context, child) => GetMaterialApp(
              localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                // GlobalMaterialLocalizations.delegate,
                // GlobalWidgetsLocalizations.delegate,
                // GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [Locale('en', 'US'), Locale('zh', 'CN')],
              debugShowCheckedModeBanner: false,
              home: landingPage(),
            ));
  }

  Widget landingPage() {
    AuthController authController = Get.put(AuthController());
    authController.getUserData();

    return GetBuilder<AuthController>(builder: (authController) {
      return authController.user != null ? HomeTabPage() : LoginPage();
    });

    // NotesPageScreen();

    // HtmlEditorExample(title: 'asd',);
  }
}
