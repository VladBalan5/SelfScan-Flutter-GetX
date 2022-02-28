import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String? buttonText;
  Function buttonFunction = () => {};
  Color buttonColor;
  Color buttonTextColor;
  double buttonHeight;

  CustomButton({
    required this.buttonHeight,
    required this.buttonText,
    required this.buttonFunction,
    required this.buttonColor,
    required this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: buttonColor,
      elevation: 0,
      minWidth: 300,
      height: buttonHeight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      onPressed: () {
        buttonFunction();
      },
      child: Text(
        '$buttonText',
        style: TextStyle(
          fontSize: 17,
          color: buttonTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
