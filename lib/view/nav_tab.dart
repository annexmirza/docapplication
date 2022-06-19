import 'package:docapplication/constants.dart';
import 'package:docapplication/controllers/nav_tab_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavTabPage extends StatelessWidget {
  NavTabPage({Key? key}) : super(key: key);
  NavTabController navTabController = Get.put(NavTabController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appbkColor,

      body: Container(
        child: GetBuilder<NavTabController>(builder: (navTabController) {
          return navTabController.allPagesScreen[navTabController.currentIndex];
        }),
      ),

      //  allPageScreen[currentPage]

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30),

              // color: Colors.white,
            ),
            child: GNav(
                padding: const EdgeInsets.only(
                    left: 24, right: 15, top: 18, bottom: 18),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                tabBackgroundColor: Color(0xffFFC41F),
                onTabChange: (index) {
                  navTabController.currentIndex = index;
                  navTabController.updatePage(index);
                },
                selectedIndex: navTabController.currentIndex,
                // iconSize: 25,
                tabs: [
                  GButton(
                    icon: Icons.home_filled,
                  ),
                  GButton(
                    icon: Icons.search,
                  ),
                  GButton(icon: Icons.person),
                  GButton(
                    icon: Icons.comment,
                  )
                ])),
      ),
    );
  }
}
