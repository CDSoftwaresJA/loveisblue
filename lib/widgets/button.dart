import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  const RoundedButtonWidget({
    Key key,
    this.buttonText,
    this.buttonColor,
    this.textColor = Colors.black,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.transparent,
      shape: StadiumBorder(side: BorderSide(color: buttonColor, width: 0.4)),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Text(
          buttonText,
          style:
              Theme.of(context).textTheme.button.copyWith(color: buttonColor),
        ),
      ),
    );
  }
}
