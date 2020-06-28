import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tip extends StatelessWidget {
  final String text;
  Tip(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(fontSize: 13, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}
