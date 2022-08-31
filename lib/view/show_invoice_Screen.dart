import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class ShowInvoiceScreen extends StatelessWidget {
  const ShowInvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              child: PDFView(
        filePath: 'assets/invoice.pdf',
      ))),
    );
  }
}
