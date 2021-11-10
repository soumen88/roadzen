import 'package:flutter/material.dart';

class QuantityBloc extends ChangeNotifier {
  int count = 0;
  // 1
  QuantityBloc();

  // 2
  void increment() {
    count++;
    notifyListeners();
  }

  // 2
  void decrement() {
    count--;
    if(count <= 0){
      count = 0;
    }

    notifyListeners();
  }
}