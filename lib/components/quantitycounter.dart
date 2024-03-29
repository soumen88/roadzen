import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadzen/constants.dart';
import 'dart:developer' as developer;
import 'package:roadzen/providers/providers.dart';

class QuantityCounter extends ConsumerWidget {

  QuantityCounter({
    Key? key,
    this.incrementCountSelected,
    this.decrementCountSelected,
    @PathParam() required this.initialCount,
  }) : super(key: key);


  final Function(int?)? incrementCountSelected;
  final Function(int?)? decrementCountSelected;
  int initialCount;
  bool isValueSet = false;
  String currentScreen = "Quantity Counter";
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    if(!isValueSet){
      isValueSet = true;
      watch(counterProvider).count = initialCount;
    }

    final count = watch(counterProvider).count;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        QtyButton(
          tap: () {
            context.read(counterProvider.notifier).decrement();
            decrementCountSelected!(count);
          },
          text: '-',
        ),

        SizedBox(width: 10),

        Text(
          '$count',
          style: TextStyle(
            fontSize: 38
          ),
        ),

        SizedBox(width: 10),

        QtyButton(
          tap: () {
            context.read(counterProvider.notifier).increment();
            incrementCountSelected!(count);
          },
          text: '+',
        )
      ],
    );
  }
}

class QtyButton extends StatelessWidget {
  const QtyButton({
    Key? key,
    @required this.tap,
    @required this.text,
  }) : super(key: key);

  final GestureTapCallback? tap;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        width: 50.0,
        height: 50.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultPadding * 0.5),
            color: kRoadZenColorUp
        ),
        child: Text(
          text!,
          style: TextStyle(
              color: whiteColor,
              fontSize: 40
          ),
        ),
      ),
    );
  }
}