import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:roadzen/booking/BookingState.dart';
class HomeScreenBloc extends ChangeNotifier{

  //A = Available -> Green
  //O = Occupied -> Terrain
  //S = Selected -> Grey
  HomeScreenBloc(){
    //initGrid();
    createGrid(5, 5);
  }
  String TAG = "HomeScreenBloc";
  List<List<BookingState>> bookingGridState = [];

  void initGrid(){
    developer.log(TAG, name: "Init grid");
    notifyListeners();
  }

  void updateGrid(int x , int y){
    developer.log(TAG, name : "Value of $x and $y");

    notifyListeners();
  }

  void createGrid(int x, int y){
    try {
      bookingGridState = [];
      for(int i = 0 ; i < x; i++){
        List<BookingState> inner = [];
        for(int j = 0 ; j < x; j++){
            inner.insert(j,BookingState.AVAILABLE);
        }
        bookingGridState.insert(i, inner);
      }
      developer.log(TAG , name : "Grid state "+ bookingGridState.toString());
      notifyListeners();
    } catch (e) {

      developer.log(TAG , name :'Printing out the message: $e');
    }
  }


}