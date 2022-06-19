import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Customtextfield extends StatelessWidget {
  String? lableName;
  TextEditingController? textEditingController;
  Customtextfield({required this.lableName, this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        // border: OutlineInputBorder(),
        labelText: lableName!,
      ),
    );
  }
}
