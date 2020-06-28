import 'package:flutter/material.dart';

class SolidButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  const SolidButton({
    Key key,
    this.buttonText,
    this.buttonColor,
    this.textColor = Colors.black,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: buttonColor,
      shape: StadiumBorder(),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Text(
          buttonText,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
