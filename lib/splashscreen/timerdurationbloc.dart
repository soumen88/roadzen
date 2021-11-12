import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as developer;


class TimerDurationBloc extends ChangeNotifier{

  String currentScreen = "TimerDurationBloc";
  bool timerExpired = false;
  void startTimer(){
    //developer.log(currentScreen, name : "Timer started");
    timerExpired = false;
    notifyListeners();
    Timer(Duration(seconds: 1), () {
      //developer.log(currentScreen, name : "Timer expired");
      timerExpired = true;
      notifyListeners();
    });
  }

}