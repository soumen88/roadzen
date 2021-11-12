import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as developer;


class TimerDurationBloc extends StateNotifier<AsyncValue<bool>>{
  TimerDurationBloc() : super(AsyncData(false));
  String currentScreen = "TimerDurationBloc";

  void startTimer(){
    //developer.log(currentScreen, name : "Timer started");
    state = AsyncData(false);
    Timer(Duration(seconds: 5), () {
      //developer.log(currentScreen, name : "Timer expired");
      state = AsyncData(true);
    });
  }

}