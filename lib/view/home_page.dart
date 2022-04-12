import 'package:docapplication/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [customButton(text: " onpress ")],
      ),
    );
  }
}
