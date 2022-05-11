import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'view/home_page.dart';
import 'view/home_tab_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //     // options: DefaultFirebaseOptions.currentPlatform
  //     );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        builder: () => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              builder: EasyLoading.init(),
              home: landingPage(),
            ));
  }
}

Widget landingPage() {
  return HomeTabPage();
  // NotesPageScreen();

  // HtmlEditorExample(title: 'asd',);
}
