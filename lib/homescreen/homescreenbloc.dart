import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:roadzen/booking/bookingstate.dart';
import 'package:roadzen/models/family.dart';
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
  int rows = 0;
  int columns = 0;

  void initGrid(){
    developer.log(TAG, name: "Init grid");
    notifyListeners();
  }

  void updateGrid(int x , int y, Family currentFamily){
    developer.log(TAG, name : "Value of $x and $y total members in family ${currentFamily.totalMembers}");
    //Iterate through current row x and check until last row
    for(int i = x ; i < rows ; i++){
      var currentRow = bookingGridState[i];
      List<int> indexKeys = [];
      bool isAvailable = currentRow.any((element) => element == BookingState.AVAILABLE);
      if(isAvailable){
        var currentVacantSeats = currentRow.where((element) => element == BookingState.AVAILABLE).toList();
        var currentVacantSeats2 = currentRow.where((element) => element == BookingState.AVAILABLE).toList().map((e) => null);
        currentVacantSeats.forEach((element) {

        });
        //arr.withIndex().filter{ it.value == 2 }.map{ it.index }
        developer.log(TAG , name: "Indexes ${currentVacantSeats2}");
      }
      break;
    }
    //notifyListeners();
  }

  void createGrid(int x, int y){
    try {
      rows = x;
      columns = y;
      bookingGridState = [];
      for(int i = 0 ; i < x; i++){
        List<BookingState> inner = [];
        for(int j = 0 ; j < x; j++){
            if( i == 0 && j == 0){
              inner.insert(j,BookingState.OCCUPIED);
            }
            else{
              inner.insert(j,BookingState.AVAILABLE);
            }

        }
        bookingGridState.insert(i, inner);
      }
      notifyListeners();
    } catch (e) {

      developer.log(TAG , name :'Printing out the message: $e');
    }
  }


}