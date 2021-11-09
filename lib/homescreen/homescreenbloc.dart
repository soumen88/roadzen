import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:roadzen/booking/bookingstate.dart';
import 'package:roadzen/booking/seatbooking.dart';
import 'package:roadzen/models/familymodel.dart';
class HomeScreenBloc extends ChangeNotifier{

  //A = Available -> Green
  //O = Occupied -> Terrain
  //S = Selected -> Grey
  HomeScreenBloc(){
    //initGrid();
    createGrid(5, 5);
  }
  String TAG = "HomeScreenBloc";
  SeatBooking? seatBookingGridState ;
  SplayTreeMap familyTreeMap = new SplayTreeMap<int, FamilyModel>();
  int rows = 0;
  int columns = 0;

  void initGrid(){
    developer.log(TAG, name: "Init grid");
    notifyListeners();
  }

  void updateGrid(int x , int y, FamilyModel currentFamily){
    try{
      developer.log(TAG, name : "Value of $x and $y total members in family ${currentFamily.totalMembers}");
      List<List<BookingState>> bookingGridState = seatBookingGridState!.currentBookingState;
      //Iterate through current row x and check until last row
      int totalMembers = currentFamily.totalMembers!;
      int numberOfSeatsNeedToBeCreated = 0;
      for(int i = x ; i < rows ; i++){
        List<BookingState> currentRow = List.from(bookingGridState[i]) ;
        bool isAvailable = currentRow.any((element) => element == BookingState.AVAILABLE);
        bool continueToNextRow = false;
        if(isAvailable){
          var availableSeats = currentRow.where((element) => element == BookingState.AVAILABLE).toList();
          continueToNextRow = availableSeats.length < totalMembers;
          if(availableSeats.length <= totalMembers ){
            numberOfSeatsNeedToBeCreated = availableSeats.length;
          }
          else{
            numberOfSeatsNeedToBeCreated = totalMembers;
          }
          currentRow.asMap().forEach((index, value) {
            if(numberOfSeatsNeedToBeCreated > 0){
              if(value == BookingState.AVAILABLE){
                currentRow[index] = BookingState.OCCUPIED;
                numberOfSeatsNeedToBeCreated--;
              }
            }
          });
          /*var startAt = currentRow.indexWhere((element) => element == BookingState.AVAILABLE);
          var endAt = currentRow.lastIndexWhere((element) => element == BookingState.AVAILABLE);
          var newList = List<BookingState>.generate(numberOfSeatsNeedToBeCreated, (i) => BookingState.OCCUPIED);
          developer.log(TAG , name : "New list Size ${newList.length}");
          currentRow.replaceRange(startAt, endAt, newList);*/
          bookingGridState.removeAt(i);
          bookingGridState.insert(i, currentRow);
          if(!continueToNextRow){
            break;
          }
          totalMembers = totalMembers - availableSeats.length;
          developer.log(TAG , name : "Continue to next row for more replacements");
        }

      }
      seatBookingGridState = new SeatBooking(currentFamily, bookingGridState);
    }
    catch(e){
      developer.log(TAG, name : "Exception occurred $e");
    }

    notifyListeners();
  }

  void createGrid(int x, int y){
    try {
      List<List<BookingState>> prepareBookingGridState = [];
      rows = x;
      columns = y;
      for(int i = 0 ; i < x; i++){
        List<BookingState> inner = [];
        for(int j = 0 ; j < x; j++){
            if( i == 2 && j == 2){
              inner.insert(j,BookingState.OCCUPIED);
            }
            else{
              inner.insert(j,BookingState.AVAILABLE);
            }
            //inner.insert(j,BookingState.AVAILABLE);
        }
        prepareBookingGridState.insert(i, inner);
      }

      List<FamilyModel> currentFamilyList = List.from(familyList);
      currentFamilyList.forEach((element) => familyTreeMap[element.id!] = element);
      seatBookingGridState = new SeatBooking(currentFamilyList.first, prepareBookingGridState);
      notifyListeners();
    } catch (e) {
      developer.log(TAG , name :'Printing out the message: $e');
    }
  }

  void test(){
    List<int> arr = [1,2,3,4,5];
    arr.sort((a, b) => a.compareTo(b));
    var abc = getNextLargerNumber(5, arr);
    if(abc == -1){
      arr.sort((a, b) => b.compareTo(a));
      developer.log(TAG , name :'Large: $abc');
    }
    developer.log(TAG , name :'Large: $abc');
  }


  int getNextLargerNumber(int number, List<int> array)
  {
    for (var i = 0; i < array.length; i++) {
      if (number < array[i]) {
        return array[i];
      }
    }
    return -1;
  }


}