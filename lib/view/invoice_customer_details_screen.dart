import 'package:docapplication/constants.dart';
import 'package:docapplication/controllers/invoice_controller.dart';
import 'package:docapplication/view/invoice_company_details_screen.dart';
import 'package:docapplication/view/invoice_items_screen.dart';
import 'package:docapplication/view/widgets/custom_button.dart';
import 'package:docapplication/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InvoiceCustomerDetailsScreen extends StatelessWidget {
  InvoiceCustomerDetailsScreen({Key? key}) : super(key: key);
  InvoiceCOntroller invoiceCOntroller = Get.put(InvoiceCOntroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appGreenColor,
        foregroundColor: Colors.white,
        title: Text('Customer Details'),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.h,
              ),
              Container(
                  width: Get.width - 40,
                  child: TextFormField(
                    controller: invoiceCOntroller.customerNameController,
                    decoration: InputDecoration(
                      labelText: 'Customer Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )),
              SizedBox(
                height: 25.h,
              ),
              Container(
                width: Get.width - 40,
                child: TextFormField(
                  controller: invoiceCOntroller.customerEmailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Container(
                width: Get.width - 40,
                child: TextFormField(
                  controller: invoiceCOntroller.customerContactController,
                  decoration: InputDecoration(
                    labelText: 'Contact Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
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
                    Get.to(() => InvoiceItemsScreen());
                    // conversionController.convertPPTToPdf();
                  },
                  radius: 10,
                  textSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ],
          ),
        ),
      ),
    );
  }
}
