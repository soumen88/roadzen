import 'package:flutter/material.dart';
import 'package:roadzen/constants.dart';

class BuyButton extends StatelessWidget {
  BuyButton({
    Key? key,
    @required this.tap,
    @required this.buttonText,
  }) : super(key: key);

  final GestureTapCallback? tap;
  String? buttonText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultPadding * 2),
            color: kRoadZenColor
        ),
        height: 50.0,
        alignment: Alignment.center,
        child: Text(
          '$buttonText',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}