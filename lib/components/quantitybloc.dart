import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class QuantityBloc extends ChangeNotifier {
  String TAG = "QuantityBloc";
  int count = 0;
  // 1
  QuantityBloc(){
    init();
  }

  void init(){
    count = 3;
    notifyListeners();
  }

  // 2
  void increment() {
    if(count <= 25){
      count++;
    }
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

  void reset(){
    count = 0;
    notifyListeners();
  }
}