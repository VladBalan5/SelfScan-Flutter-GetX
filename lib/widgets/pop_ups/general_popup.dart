import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:selfscancorafluttergetx/constants/colors.dart';
import 'package:selfscancorafluttergetx/widgets/buttons/custom_button.dart';

class GeneralPopUp extends StatelessWidget {
  String content = '';
  bool showFunctionButton = false;
  String functionButtonText = '';
  Function buttonFunction = () => {};
  Function onDismiss = () => {};

  GeneralPopUp({
    required this.content,
    required this.showFunctionButton,
    required this.functionButtonText,
    required this.buttonFunction,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: kBlack.withOpacity(0.5),
        ),
        AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 25,
            horizontal: 10,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                content,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              showFunctionButton
                  ? Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: CustomButton(
                        buttonHeight: 45,
                        buttonText: '$functionButtonText',
                        buttonFunction: () => {
                          buttonFunction(),
                        },
                        buttonColor: kBlue,
                        buttonTextColor: kWhite,
                      ),
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                child: CustomButton(
                  buttonHeight: 45,
                  buttonText: 'Anuleaza',
                  buttonFunction: () => {
                    onDismiss(),
                  },
                  buttonColor: kLightGrey,
                  buttonTextColor: kBlack,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
