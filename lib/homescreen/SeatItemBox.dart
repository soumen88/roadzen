import 'package:flutter/material.dart';

class SeatItemBox extends StatelessWidget {
  const SeatItemBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomeScreen"),),
      body: Center(
          child: Column(
            children: [
              Container(
                height: 30.0,
                width: 30.0,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
              ),
            ],
          )
      ),
    );
  }
}
