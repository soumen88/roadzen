import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer' as developer;
import 'package:flutter_riverpod/flutter_riverpod.dart';


class BottomBarStatusBloc extends ChangeNotifier{

  String currentScreen = "ConnectivityDetectorBloc";
  bool currentStatus = false;
  String? textMessage;
  bool? isError;

  void statusListener(String message, bool isErrorMessage) async{
    currentStatus = true;
    textMessage = message;
    isError = isErrorMessage;
    notifyListeners();
  }

  void startTimer(){
    Timer(Duration(seconds: 1), () {
      currentStatus = false;
      notifyListeners();
    });
  }

}