import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class STextField extends StatelessWidget {
  TextEditingController controller;
  String hint;
  STextField({this.controller, this.hint});
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: this.controller,
    );
  }
}
