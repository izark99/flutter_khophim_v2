import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final Function onPressed;
  final TextStyle textStyle;

  const CustomButton({
    Key key,
    @required this.buttonName,
    this.onPressed,
    this.textStyle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        primary: Theme.of(context).canvasColor,
        backgroundColor: Theme.of(context).accentColor,
        textStyle: textStyle ?? Theme.of(context).textTheme.bodyText1,
      ),
      child: Text(
        buttonName,
        textAlign: TextAlign.center,
      ),
    );
  }
}
