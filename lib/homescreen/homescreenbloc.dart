import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:roadzen/booking/bookingstate.dart';
import 'package:roadzen/booking/seatbooking.dart';
import 'package:roadzen/constants.dart';
import 'package:roadzen/mixin/message_notifier_mixin.dart';
import 'package:roadzen/models/familymodel.dart';
class HomeScreenBloc extends ChangeNotifier with MessageNotifierMixin {

  //A = Available -> Green
  //O = Occupied -> Terrain
  //S = Selected -> Grey
  String TAG = "HomeScreenBloc";
  SeatBooking? seatBookingGridState ;
  List<SeatBooking> seatBookingGridList = [] ;
  // here key is row and List<int> are columns
  SplayTreeMap indexesFilled = new SplayTreeMap<int, List<int>>() ;
  SplayTreeMap familyTreeMap = new SplayTreeMap<int, FamilyModel>();
  FamilyModel? activeFamilyModel;
  int rows = 0;
  int columns = 0;
  int someCounter = 0;


  void updateGrid(int x , int y, FamilyModel currentFamily){
    if(x == rows - 1){
      traverseReverseGrid(x,y, currentFamily);
    }
    else{
      notifyInfo('Successfully called load() method');
      traverseForwardGrid(x,y, currentFamily);
    }
  }

  void traverseForwardGrid(int x , int y, FamilyModel currentFamily){
    try{
      developer.log(TAG, name : "Value of $x and $y total members in family ${currentFamily.totalMembers}");
      List<List<BookingState>> bookingGridState = seatBookingGridState!.currentBookingState;
      SplayTreeMap bookingSeats = new SplayTreeMap<int, List<int>>();
      //Iterate through current row x and check until last row
      int totalMembers = currentFamily.totalMembers!;
      int numberOfSeatsNeedToBeCreated = currentFamily.totalMembers!;
      int selectedrowIndex = x;
      int selectedColIndex = y;
      //for(int i = selectedrowIndex ; i < rows ; i++){
      while(true){
        List<BookingState> currentRow = List.from(bookingGridState[selectedrowIndex]) ;
        //Check if there is at least one available seat in that row
        bool isAvailable = currentRow.any((element) => element == BookingState.AVAILABLE);
        bool continueToNextRow = false;
        if(isAvailable){
          List<int> currentRowIndexesFilled = [];
          for(int j = selectedColIndex ; j < columns ; j++){
            if(currentRow[j] == BookingState.AVAILABLE){
              currentRowIndexesFilled.add(j);
              currentRow[j] = BookingState.OCCUPIED;
              numberOfSeatsNeedToBeCreated--;
            }
            if(numberOfSeatsNeedToBeCreated == 0){
              break;
            }
          }
          continueToNextRow = numberOfSeatsNeedToBeCreated > 0;
          indexesFilled[selectedrowIndex] = currentRowIndexesFilled;
          bookingSeats[selectedrowIndex] = currentRowIndexesFilled;
          bookingGridState.removeAt(selectedrowIndex);
          bookingGridState.insert(selectedrowIndex, currentRow);
          developer.log(TAG , name : "Booking seats " + bookingSeats.toString());
          if(!continueToNextRow){
            break;
          }
          selectedColIndex = 0;
          //If last row wasnt successful in giving seats then go to the first one
          if(selectedrowIndex == rows - 1){
            selectedrowIndex = 0;
          }
          else{
            selectedrowIndex++;
          }
        }
      }
      currentFamily.seatDetails = SplayTreeMap.from(bookingSeats);
      familyTreeMap[currentFamily.id!] = currentFamily;
      seatBookingGridState = new SeatBooking(currentFamily, bookingGridState);
    }
    catch(e){
      developer.log(TAG, name : "Exception occurred $e");
    }
    notifyListeners();
  }

  void traverseReverseGrid(int x , int y, FamilyModel currentFamily){
    try{
      developer.log(TAG, name : "Value of $x and $y total members in family ${currentFamily.totalMembers}");
      List<List<BookingState>> bookingGridState = seatBookingGridState!.currentBookingState;
      //Iterate through current row x and check until last row
      int totalMembers = currentFamily.totalMembers!;
      int numberOfSeatsNeedToBeCreated = 0;
      for(int i = x ; i > 0 ; i--){
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
          List<int> currentRowIndexesFilled = [];
          currentRow.asMap().forEach((index, value) {
            if(numberOfSeatsNeedToBeCreated > 0){
              if(value == BookingState.AVAILABLE){
                currentRowIndexesFilled.add(index);
                currentRow[index] = BookingState.OCCUPIED;
                numberOfSeatsNeedToBeCreated--;
              }
            }
          });
          indexesFilled[i] = currentRowIndexesFilled;
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

  void deselectSeats(FamilyModel familyModel){
    try{
      FamilyModel savedFamilyDetails = familyTreeMap[familyModel.id];
      SplayTreeMap bookedSeats = new SplayTreeMap<int, List<int>>();
      bookedSeats.addAll(savedFamilyDetails.seatDetails);
      List<List<BookingState>> bookingGridState = seatBookingGridState!.currentBookingState;
      bookedSeats.forEach((key, value) {
        int rowId = key as int;
        List<int> seatIndexes =  value as List<int>;
        List<BookingState> currentRow = List.from(bookingGridState[rowId]) ;
        int startAt = seatIndexes.first;
        int endAt = seatIndexes.last;
        var newList = List.generate(seatIndexes.length, (i) => BookingState.AVAILABLE);
        currentRow.replaceRange(startAt, endAt, newList);
        developer.log(TAG , name : "$value");
        bookingGridState.removeAt(rowId);
        bookingGridState.insert(rowId, currentRow);

      });
      savedFamilyDetails.seatDetails.clear();
      familyTreeMap[savedFamilyDetails.id!] = savedFamilyDetails;
      seatBookingGridState = new SeatBooking(savedFamilyDetails, bookingGridState);
      notifyListeners();
    }
    catch(e){
      developer.log(TAG , name: "");
    }
  }

  void createGrid(int x, int y, FamilyModel familyModel){
    try {
      List<List<BookingState>> prepareBookingGridState = [];
      rows = x;
      columns = y;
      for(int i = 0 ; i < x; i++){
        List<BookingState> inner = [];
        for(int j = 0 ; j < x; j++){
            /*if( i == 2 && j == 2){
              inner.insert(j,BookingState.OCCUPIED);
            }
            else{
              inner.insert(j,BookingState.AVAILABLE);
            }*/
            inner.insert(j,BookingState.AVAILABLE);
        }
        prepareBookingGridState.insert(i, inner);
      }


      seatBookingGridState = new SeatBooking(familyModel, prepareBookingGridState);
      notifyListeners();
    } catch (e) {
      developer.log(TAG , name :'Printing out the message: $e');
    }
  }

  void markOccupiedSeats(){
    developer.log(TAG , name:  "Current row indexes filled ${indexesFilled}");
    List<List<BookingState>> bookingGridState = seatBookingGridState!.currentBookingState;
    for(int  i = 0; i< rows; i++){
      List<BookingState> currentRow = List.from(bookingGridState[i]);
      if(indexesFilled.containsKey(i)){
        List<int> entriesFilled = indexesFilled[i];
        currentRow.asMap().forEach((index, value) {
            if(entriesFilled.contains(index)){
              currentRow[index] = BookingState.SELECTED;
            }
        });
        bookingGridState.removeAt(i);
        bookingGridState.insert(i, currentRow);
      }
    }
    notifyListeners();
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


  int getNextLargerNumber(int number, List<int> array) {
    for (var i = 0; i < array.length; i++) {
      if (number < array[i]) {
        return array[i];
      }
    }
    return -1;
  }

  void getAllFamilyMembersAdded(int familyId, FamilyModel familyModel){
    if(familyId == 0){
      return;
    }
    if(!familyTreeMap.containsKey(familyId)){
      familyTreeMap[familyId] = familyModel;
      familyTreeMap.forEach((key, value) {
        developer.log(TAG , name:"$key added with ${value}");
      });
      createGrid(gridRows, gridColumns, familyModel);
      activeFamilyModel = familyModel;
    }
    else{
      throw Exception('$familyId Family Id was already present');
    }

  }

}