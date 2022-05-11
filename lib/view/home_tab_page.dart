import 'package:docapplication/view/widgets/file_iocn_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTabPage extends StatelessWidget {
  // const ({ Key? key }) : super(key: key);
  var radius = Radius.circular(10.r);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Document reader',
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[700],
          elevation: 0,
          // give the app bar rounded corners
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(1.0),
              bottomRight: Radius.circular(1.0),
            ),
          ),
          leading: Icon(
            Icons.menu,
          ),
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // construct the profile details widget here
            Container(
              height: 280.h,
              color: Colors.black,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FileInfoContainer(
                        svgUrl: "assets/quicknotes.svg",
                        onTap: () {},
                        title: "Quick Notes",
                      ),
                      FileInfoContainer(
                        svgUrl: "assets/pdftojpeg.svg",
                        onTap: () {},
                        title: "PDF to JPEG",
                      ),
                      FileInfoContainer(
                        svgUrl: "assets/docstojpeg.svg",
                        onTap: () {},
                        title: "DOCS to JPEG",
                      ),
                      FileInfoContainer(
                        svgUrl: "assets/docstopdf.svg",
                        onTap: () {},
                        title: "DOCS to PDF",
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 18.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FileInfoContainer(
                          svgUrl: "assets/docstohtml.svg",
                          onTap: () {},
                          title: "DOCS to HTML",
                        ),
                        FileInfoContainer(
                          svgUrl: "assets/pdftojpeg.svg",
                          onTap: () {},
                          title: "PDF to JPEG",
                        ),
                        FileInfoContainer(
                          svgUrl: "assets/ppttopdf.svg",
                          onTap: () {},
                          title: "PPT to PDF",
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        FileInfoContainer(
                          svgUrl: "assets/more.svg",
                          onTap: () {},
                          title: "More",
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            // the tab bar with two items
            SizedBox(
              height: 50,
              child: AppBar(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: TabBar(
                        labelColor: Colors.black,
                        indicatorColor: Colors.black,

                        // indicatorSize: TabBarIndicatorSize,
                        indicator: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black, width: 3.0),
                          ),
                        ),

                        tabs: [
                          Tab(
                            text: "Recent",
                          ),
                          Tab(
                            text: "Favourite",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'Recent',
                      ),
                    ),
                  ),

                  // second tab bar viiew widget
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'Favourite',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class HomeTabPage extends StatefulWidget {
//   @override
//   profilePageState createState() => profilePageState();
// }

// class profilePageState extends State<profilePage> {

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'My Profile',
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.grey[700].withOpacity(0.4),
//           elevation: 0,
//           // give the app bar rounded corners
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(20.0),
//               bottomRight: Radius.circular(20.0),
//             ),
//           ),
//           leading: Icon(
//             Icons.menu,
//           ),
//         ),
//         body: Column(
//           children: <Widget>[
//             // construct the profile details widget here
//             SizedBox(
//               height: 180,
//               child: Center(
//                 child: Text(
//                   'Profile Details Goes here',
//                 ),
//               ),
//             ),

//             // the tab bar with two items
//             SizedBox(
//               height: 50,
//               child: AppBar(
//                 bottom: TabBar(
//                   tabs: [
//                     Tab(
//                       icon: Icon(Icons.directions_bike),
//                     ),
//                     Tab(
//                       icon: Icon(
//                         Icons.directions_car,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // create widgets for each tab bar here
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   // first tab bar view widget
//                   Container(
//                      color: Colors.red,
//                     child: Center(
//                       child: Text(
//                         'Bike',
//                       ),
//                     ),
//                   ),

//                   // second tab bar viiew widget
//                   Container(
//                      color: Colors.pink,
//                     child: Center(
//                       child: Text(
//                         'Car',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
