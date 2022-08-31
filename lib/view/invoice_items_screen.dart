import 'package:docapplication/constants.dart';
import 'package:docapplication/controllers/invoice_controller.dart';
import 'package:docapplication/view/invoice_company_details_screen.dart';
import 'package:docapplication/view/widgets/custom_button.dart';
import 'package:docapplication/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InvoiceItemsScreen extends StatelessWidget {
  InvoiceItemsScreen({Key? key}) : super(key: key);
  InvoiceCOntroller invoiceCOntroller = Get.put(InvoiceCOntroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appGreenColor,
        foregroundColor: Colors.white,
        title: Text('Items'),
      ),
      body: SafeArea(
        child: GetBuilder<InvoiceCOntroller>(builder: (invoiceController) {
          return Column(
            children: [
              SizedBox(
                height: 100.h,
              ),
              for (int i = 0; i < invoiceController.numberOfItems; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 20.h),
                        height: 50.h,
                        width: Get.width / 2.5,
                        child: TextFormField(
                          onChanged: (value) => {
                            invoiceController.addInvoiceItemName(value, i),
                          },
                          decoration: InputDecoration(
                            labelText: 'Item Name',
                            labelStyle: TextStyle(fontSize: 12.sp),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        )),
                    SizedBox(
                      width: 8.w,
                    ),
                    Container(
                        width: Get.width / 5,
                        height: 50.h,
                        child: TextFormField(
                          onChanged: (value) => {
                            invoiceController.addInvoiceItemQuantity(
                                int.parse(value), i),
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Quantity',
                            labelStyle: TextStyle(fontSize: 12.sp),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        )),
                    SizedBox(
                      width: 8.w,
                    ),
                    Container(
                        width: Get.width / 5,
                        height: 50.h,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) => {
                            invoiceController.addInvoiceItemPrice(
                                double.parse(value), i),
                          },
                          decoration: InputDecoration(
                            labelText: 'Price',
                            labelStyle: TextStyle(fontSize: 12.sp),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        )),
                    SizedBox(
                      width: 5.w,
                    ),
                    InkWell(
                      onTap: () {
                        invoiceController.updateNumberOfItems();
                      },
                      child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: appdarkGreyColor,
                          ),
                          width: Get.width / 8,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              SizedBox(
                height: 25.h,
              ),
              customButton(
                  text: "Start",
                  height: 60.h,
                  width: 220.w,
                  color: appGreenColor,
                  onTapFunction: () {
                    // Get.to(() => InvoiceCompanyDetailsScreen());
                    invoiceCOntroller.generateFile();
                  },
                  radius: 10,
                  textSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ],
          );
        }),
      ),
    );
  }
}
