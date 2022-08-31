import 'package:docapplication/view/show_invoice_Screen.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class InvoiceCOntroller extends GetxController {
  String savedInvoicePath = '';
  int numberOfItems = 1;
  double total = 0.0;
  var a = "Deveon";
  TextEditingController invoiceNumberController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  // TextEditingController dateController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerEmailController = TextEditingController();
  TextEditingController customerContactController = TextEditingController();
  List<InvoiceItemModel> items = [];
  updateNumberOfItems() {
    numberOfItems++;
    update();
  }

  addInvoiceItemName(String value, int index) {
    InvoiceItemModel invoiceItemModel = InvoiceItemModel();
    invoiceItemModel.itemName = "${value}";
    if (items.length > index) {
      items[index].itemName = "${value}";
    } else {
      items.add(invoiceItemModel);
    }

    update();
  }

  addInvoiceItemQuantity(int value, int index) {
    InvoiceItemModel invoiceItemModel = InvoiceItemModel();
    invoiceItemModel.quantity = value;
    if (items.length > index) {
      items[index].quantity = value;
    } else {
      items.add(invoiceItemModel);
    }

    update();
  }

  addInvoiceItemPrice(double value, int index) {
    InvoiceItemModel invoiceItemModel = InvoiceItemModel();
    invoiceItemModel.price = value;
    if (items.length > index) {
      items[index].price = value;
    } else {
      items.add(invoiceItemModel);
    }

    update();
  }

  generateFile() async {
    total = 0.0;
    await Permission.storage.request();
    for (InvoiceItemModel item in items) {
      total += item.price!;
    }
    var htmlContent = '''
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />

		<title>A simple, clean, and responsive HTML invoice template</title>

		<!-- Favicon -->
		<link rel="icon" href="./images/favicon.png" type="image/x-icon" />

		<!-- Invoice styling -->
		<style>
			body {
				font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
				text-align: center;
				color: #777;
			}

			body h1 {
				font-weight: 300;
				margin-bottom: 0px;
				padding-bottom: 0px;
				color: #000;
			}

			body h3 {
				font-weight: 300;
				margin-top: 10px;
				margin-bottom: 20px;
				font-style: italic;
				color: #555;
			}

			body a {
				color: #06f;
			}

			.invoice-box {
				max-width: 800px;
				margin: auto;
				padding: 30px;
				border: 1px solid #eee;
				box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
				font-size: 16px;
				line-height: 24px;
				font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
				color: #555;
			}

			.invoice-box table {
				width: 100%;
				line-height: inherit;
				text-align: left;
				border-collapse: collapse;
			}

			.invoice-box table td {
				padding: 5px;
				vertical-align: top;
			}

			.invoice-box table tr td:nth-child(2) {
				text-align: right;
			}

			.invoice-box table tr.top table td {
				padding-bottom: 20px;
			}

			.invoice-box table tr.top table td.title {
				font-size: 45px;
				line-height: 45px;
				color: #333;
			}

			.invoice-box table tr.information table td {
				padding-bottom: 40px;
			}

			.invoice-box table tr.heading td {
				background: #eee;
				border-bottom: 1px solid #ddd;
				font-weight: bold;
        text-align: left;
			}

			.invoice-box table tr.details td {
				padding-bottom: 20px;
			}

			.invoice-box table tr.item td {
				border-bottom: 1px solid #eee;
        margin-right: 10px;
        text-align: left;
			}

			.invoice-box table tr.item.last td {
				border-bottom: none;
			}

			.invoice-box table tr.total td:nth-child(2) {
				border-top: 2px solid #eee;
				font-weight: bold;
			}

			@media only screen and (max-width: 600px) {
				.invoice-box table tr.top table td {
					width: 100%;
					display: block;
					text-align: center;
				}

				.invoice-box table tr.information table td {
					width: 100%;
					display: block;
					text-align: center;
				}
			}
		</style>
	</head>

	<body>
		

		<div class="invoice-box">
			<table>
				<tr class="top">
					<td colspan="2">
						<table>
							<tr>
								<td class="title">
									<h1>Invoice</h1>
								</td>

								<td>
									Invoice #: ${invoiceNumberController.text}<br />
									Created: ${DateTime.now()}<br />
									Due: ${dueDateController.text}
								</td>
							</tr>
						</table>
					</td>
				</tr>

				<tr class="information">
					<td colspan="2">
						<table>
							<tr>
								<td>
									${companyNameController.text}<br />
									${companyAddressController.text}
									
								</td>
             
								<td>
									${customerNameController.text}<br />
									${customerNameController.text}<br />
									${customerContactController.text}
								</td>
							</tr>
						</table>
					</td>
				</tr>

				<tr class="heading">
					<td>Item</td>
          <td>Quantity</td>
					<td>Price</td>
				</tr>
      ${List.generate(items.length, (index) => '''<tr class="item">
					<td>${items[index].itemName}</td>
            <td>${items[index].quantity}</td>
					<td>\$${items[index].price}</td>
				</tr>''')}
				


				<tr class="total">
					<td></td>
<td></td>
					<td>Total: \$${total}</td>
				</tr>
			</table>
		</div>
	</body>
</html>
''';

    if (await Permission.storage.isGranted == true) {
      String localPath = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      var targetPath = "$localPath";
      var targetFileName = "invoce ${invoiceNumberController.text}";

      var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
          htmlContent, localPath, targetFileName);
      if (generatedPdfFile.path != null) {
        Get.snackbar(
          "Success",
          "Invoice Generated",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3),
          icon: Icon(Icons.done),
        );
        savedInvoicePath = generatedPdfFile.path;
        update();
        Get.to(() => ShowInvoiceScreen());
      }
    } else {
      Get.snackbar(
        "Permission Denied",
        "Please grant permission to access storage",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        snackStyle: SnackStyle.FLOATING,
        duration: Duration(seconds: 3),
        icon: Icon(Icons.error),
      );
    }
  }
}

class InvoiceItemModel {
  String? itemName;
  int? quantity;
  double? price;
  InvoiceItemModel({this.itemName, this.quantity, this.price});
}
