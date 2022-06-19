import 'package:docapplication/view/home_tab_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class NavTabController extends GetxController {
  int currentIndex = 0;
  /* --------------------------------- bottomAppBar --------------------------------- */
  List allPagesScreen = [
    HomeTabPage(),
    Container(
      height: 400,
      width: 400,
      color: Colors.amber,
      child: Text(" page 1"),
    ),
    Container(
      height: 400,
      width: 400,
      color: Colors.red,
      child: Text(" page 1"),
    ),
    Container(
      height: 400,
      width: 400,
      color: Colors.blue,
      child: Text(" page 1"),
    )
    // SearchPage(),
    // AboutPage(),
    // ChatsPage()
    //  ProfilePage(),

    // OverViewPage(),
    // StoryPage(),
    // HacksDetailsPage()

    // AboutPage()
    // OverViewPage()
  ];

  updatePage(index) {
    index = allPagesScreen[currentIndex];
    update();
  }
}
