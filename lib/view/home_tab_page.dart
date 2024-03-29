import 'package:docapplication/constants.dart';
import 'package:docapplication/controllers/color_controller.dart';
import 'package:docapplication/controllers/file_controller.dart';
import 'package:docapplication/model/file_model.dart';
import 'package:docapplication/view/doc_to_jpeg_mid_page.dart';
import 'package:docapplication/view/doc_to_pdf_mid_page.dart';
import 'package:docapplication/view/more_screen.dart';
import 'package:docapplication/view/quick_notes/notes_page.dart';
import 'package:docapplication/view/widgets/custom_text.dart';
import 'package:docapplication/view/widgets/file_iocn_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../controllers/conversion_controller.dart';
import 'PPT_to_Pdf_mid_page...dart';
import 'pdf_to_jpeg_mid_page.dart';
import 'Doc_to_Html_mid_page..dart';
import 'excel_to_pdf_page.dart';
// import 'package:file_icon/file_icon.dart';

class HomeTabPage extends StatelessWidget {
  // const ({ Key? key }) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>(); // ADD THIS LINE

  var radius = Radius.circular(10.r);
  ColorController colorController = Get.put(ColorController());
  ConversionController conversionController = Get.put(ConversionController());
  FileController fileController = Get.put(FileController());
  @override
  Widget build(BuildContext context) {
    // });
    if (!fileController.isLoading) fileController.getMyFiles();

    return DefaultTabController(
      length: 2,
      child: GetBuilder<ColorController>(builder: (colorController) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                fileController.openFile();
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.blue),
          key: _scaffoldKey,
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xff282D5A),
                  ),
                  child: Text(''),
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                  ),
                  title: const Text('Page 1'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.train,
                  ),
                  title: const Text('Page 2'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: CustomText(
              titletext: 'Document Reader',
              fontWeight: FontWeight.bold,
            ),
            centerTitle: true,
            backgroundColor: Color(0xff111b21),
            elevation: 0,
            // give the app bar rounded corners
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(1.0),
                bottomRight: Radius.circular(1.0),
              ),
            ),
            leading: GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                child: Icon(Icons.menu)),
            // GetBuilder<ColorController>(builder: (colorController) {
            //   return Transform.scale(
            //       scale: 1.5,
            //       child: Switch(
            //         onChanged: colorController.toggleSwitch,
            //         value: colorController.isSwitched,
            //         activeColor: apporengeColor,
            //         activeTrackColor: appGreenColor,
            //         inactiveThumbColor: appDarkBlueColor,
            //         inactiveTrackColor: appDarkBlueColor,
            //       ));
            // }),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GetBuilder<ConversionController>(builder: (conversionController) {
                return Container(
                  height: 220.h,
                  color: Color(0xff35343a),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FileInfoContainer(
                            svgUrl: "assets/quicknotes.svg",
                            onTap: () {
                              Get.to(() => NotesPage());
                            },
                            title: "Quick Notes",
                          ),
                          FileInfoContainer(
                            svgUrl: "assets/pdftojpeg.svg",
                            onTap: () {
                              Get.to(() => PDFToJpegMidScreen());
                            },
                            title: "PDF to JPEG",
                          ),
                          FileInfoContainer(
                            svgUrl: "assets/docstojpeg.svg",
                            onTap: () {
                              Get.to(() => DocToJpegMidScreen());
                            },
                            title: "DOCS to JPEG",
                          ),
                          FileInfoContainer(
                            svgUrl: "assets/docstopdf.svg",
                            onTap: () {
                              Get.to(() => DoctoPdfmidScreen());
                            },
                            title: "DOCS to PDF",
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 18.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FileInfoContainer(
                              svgUrl: "assets/docstohtml.svg",
                              onTap: () {
                                Get.to(() => DoctoHtmlMidScreen());
                              },
                              title: "DOCS to HTML",
                            ),
                            FileInfoContainer(
                              svgUrl: "assets/ppttopdf.svg",
                              onTap: () {
                                Get.to(() => PpttoPdfMidScreen());
                              },
                              title: "PPT to PDF",
                            ),
                            FileInfoContainer(
                              svgUrl: "assets/exceltopdf.svg",
                              onTap: () {
                                Get.to(() => ExcelToPdfMidScreen());
                              },
                              title: "Excel to PDF",
                            ),
                            FileInfoContainer(
                              svgUrl: "assets/more.svg",
                              onTap: () {
                                Get.to(() => MoreScreen());
                              },
                              title: "More",
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
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
                              bottom:
                                  BorderSide(color: Colors.black, width: 3.0),
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
                      child:
                          GetBuilder<FileController>(builder: (fileController) {
                        fileController.clearFileExtension();

                        return SingleChildScrollView(
                          child: fileController.isLoading
                              ? Center(
                                  child: CircularPercentIndicator(
                                    progressColor: Colors.blue,
                                    center: Text(
                                      'Downloading Files... \n              ${fileController.currentDownloadingFile} of ${fileController.myFiles.length}',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    radius: 100.r,
                                    percent: fileController.progress,
                                  ),
                                )
                              : Column(
                                  children: [
                                    for (FileModel file
                                        in fileController.fileList)
                                      Column(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                fileController.setFileExtension(
                                                    file.extension!);
                                                fileController
                                                    .setFilePath(file.path!);
                                              },
                                              child: Container(
                                                height: 60.sp,
                                                padding: EdgeInsets.all(10.sp),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/${file.extension!.substring(1)}.svg',
                                                      width: 30.w,
                                                      height: 30.h,
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    SizedBox(
                                                      width: Get.width - 150,
                                                      child: Text(
                                                        '${file.name}',
                                                        overflow:
                                                            TextOverflow.fade,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                              // child: Container(
                                              //   margin: EdgeInsets.only(top: 10.h),
                                              //   height: 50,
                                              //   width: Get.width,
                                              //   color: Colors.black,
                                              //   child: Center(
                                              //     child: Text(
                                              //       '${file.name}${file.extension}',
                                              //       overflow: TextOverflow.fade,
                                              //       maxLines: 1,
                                              //       style: GoogleFonts.roboto(
                                              //         fontSize: 20,
                                              //         color: Colors.white,
                                              //         fontWeight: FontWeight.bold,
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),

                                              ),
                                          Divider(
                                            color: Colors.black,
                                            thickness: 1,
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                        );
                      }),
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
        );
      }),
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
