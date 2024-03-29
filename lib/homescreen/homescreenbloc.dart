import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:roadzen/booking/bookingstate.dart';
import 'package:roadzen/booking/seatbooking.dart';
import 'package:roadzen/components/iterable_extensions.dart';
import 'package:roadzen/constants.dart';
import 'package:roadzen/mixin/message_notifier_mixin.dart';
import 'package:dartz/dartz.dart';
import 'package:roadzen/models/familymodel.dart';
class HomeScreenBloc extends ChangeNotifier with MessageNotifierMixin {

  //A = Available -> Green
  //O = Occupied -> Terrain
  //S = Selected -> Grey
  String TAG = "HomeScreenBloc";
  SeatBooking? seatBookingGridState ;

  // here key is row and List<int> are columns
  SplayTreeMap familyTreeMap = new SplayTreeMap<int, FamilyModel>();
  FamilyModel? activeFamilyModel;
  int rows = 0;
  int columns = 0;
  bool isSeatsSelected = false;
  bool isGridCreated = false;


  bool updateGrid(int x , int y, FamilyModel currentFamily){
    bool isBooking = isBookingDone(currentFamily.id!, false);
    if(isBooking){
      //notifyError("Unselect current Seats to continue");
      developer.log(TAG, name : "Unselect current Seats to continue");
      return true;
    }
    bool isReverseTraverse = decideTraverse(x, y);
    if(isReverseTraverse){
      traverseReverseGrid(x,y, currentFamily);
    }
    else{
      traverseForwardGrid(x,y, currentFamily);
    }
    /*if(x == rows - 1){
      traverseReverseGrid(x,y, currentFamily);
    }
    else{
      traverseForwardGrid(x,y, currentFamily);
    }*/
    return false;
  }

  bool decideTraverse(int x, int y) {
    developer.log(TAG , name: "");
    if(x > 2){
      return true;
    }
    else if( x < 2){
      return false;
    }
    else{
      return false;
    }
  }

  void traverseForwardGrid(int x , int y, FamilyModel currentFamily){
    developer.log(TAG, name : "Value of $x and $y total members in family ${currentFamily.totalMembers}");
    List<List<BookingState>> bookingGridState = seatBookingGridState!.currentBookingState;
    SplayTreeMap bookingSeats = new SplayTreeMap<int, List<int>>();
    //Iterate through current row x and check until last row
    int numberOfSeatsNeedToBeCreated = currentFamily.totalMembers!;
    int selectedrowIndex = x;
    int selectedColIndex = y;
    List<BookingState> currentRow = List.from(bookingGridState[selectedrowIndex]);
    //Check if there is at least one available seat in that row
    bool isAvailable = currentRow.any((element) => element == BookingState.AVAILABLE);
    if(isAvailable){
      //check if the available row is self sufficient to give seats
      List<BookingState> availableSeats = currentRow.where((element) => element == BookingState.AVAILABLE).toList();
      if(availableSeats.length >= numberOfSeatsNeedToBeCreated){
        //Decide if left seats are empty or right
        List<int> currentRowIndexesFilled = [];
        while(true){
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
          for(int j = selectedColIndex ; j > 0 ; j--){
            if(currentRow[j] == BookingState.AVAILABLE){
              currentRowIndexesFilled.add(j);
              currentRow[j] = BookingState.OCCUPIED;
              numberOfSeatsNeedToBeCreated--;
            }
            if(numberOfSeatsNeedToBeCreated == 0){
              break;
            }
          }
          if(numberOfSeatsNeedToBeCreated == 0){
            break;
          }
          selectedColIndex = 0;
        }
        if(bookingSeats.containsKey(selectedrowIndex)){
          List<int> temp = bookingSeats[selectedrowIndex]! ;
          temp.addAll(currentRowIndexesFilled);
          bookingSeats[selectedrowIndex] = temp;
        }
        else{
          bookingSeats[selectedrowIndex] = currentRowIndexesFilled;
        }

        bookingGridState.removeAt(selectedrowIndex);
        bookingGridState.insert(selectedrowIndex, currentRow);
      }
      else{
        while(true) {
          List<BookingState> currentRow = List.from(bookingGridState[selectedrowIndex]);
          bool continueToNextRow = false;
          List<int> currentRowIndexesFilled = [];
          for (int j = selectedColIndex; j < columns; j++) {
            if (currentRow[j] == BookingState.AVAILABLE) {
              currentRowIndexesFilled.add(j);
              currentRow[j] = BookingState.OCCUPIED;
              numberOfSeatsNeedToBeCreated--;
            }
            if (numberOfSeatsNeedToBeCreated == 0) {
              break;
            }
          }
          continueToNextRow = numberOfSeatsNeedToBeCreated > 0;
          if (bookingSeats.containsKey(selectedrowIndex)) {
            List<int> temp = bookingSeats[selectedrowIndex]!;
            temp.addAll(currentRowIndexesFilled);
            bookingSeats[selectedrowIndex] = temp;
          }
          else {
            bookingSeats[selectedrowIndex] = currentRowIndexesFilled;
          }
          bookingGridState.removeAt(selectedrowIndex);
          bookingGridState.insert(selectedrowIndex, currentRow);
          developer.log(TAG, name: "Booking seats " + bookingSeats.toString());
          if (!continueToNextRow) {
            break;
          }
          selectedColIndex = 0;
          //If last row wasnt successful in giving seats then go to the first one
          if (selectedrowIndex == rows - 1) {
            selectedrowIndex = 0;
          }
          else {
            selectedrowIndex++;
          }
        }
      }
    }
    else{
      selectedColIndex = 0;
      if(selectedrowIndex == rows - 1){
        selectedrowIndex = 0;
      }
      else{
        selectedrowIndex++;
      }
    }

    currentFamily.seatDetails = SplayTreeMap.from(bookingSeats);
    familyTreeMap[currentFamily.id!] = currentFamily;
    seatBookingGridState = new SeatBooking(bookingGridState);
    //notifyInfo('Added ${currentFamily.totalMembers} tickets');
    notifyListeners();
  }

  void traverseReverseGrid(int x , int y, FamilyModel currentFamily){
    try{
      developer.log(TAG, name : "Value of $x and $y total members in family ${currentFamily.totalMembers}");
      List<List<BookingState>> bookingGridState = seatBookingGridState!.currentBookingState;
      SplayTreeMap<int, List<int>> bookingSeats = new SplayTreeMap<int, List<int>>();

      //Iterate through current row x and check until last row
      int numberOfSeatsNeedToBeCreated = currentFamily.totalMembers!;
      int selectedrowIndex = x;
      int selectedColIndex = y;

      List<BookingState> currentRow = List.from(bookingGridState[selectedrowIndex]);
      //Check if there is at least one available seat in that row
      bool isAvailable = currentRow.any((element) => element == BookingState.AVAILABLE);
      bool continueToNextRow = false;
      if(isAvailable){
        List<BookingState> availableSeats = currentRow.where((element) => element == BookingState.AVAILABLE).toList();
        //check if the available row is self sufficient to give seats
        if(availableSeats.length >= numberOfSeatsNeedToBeCreated){
          //Decide if left seats are empty or right
          List<int> currentRowIndexesFilled = [];
          while(true){
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
            for(int j = selectedColIndex ; j > 0 ; j--){
              if(currentRow[j] == BookingState.AVAILABLE){
                currentRowIndexesFilled.add(j);
                currentRow[j] = BookingState.OCCUPIED;
                numberOfSeatsNeedToBeCreated--;
              }
              if(numberOfSeatsNeedToBeCreated == 0){
                break;
              }
            }
            if(numberOfSeatsNeedToBeCreated == 0){
              break;
            }
            selectedColIndex = 0;
          }
          if(bookingSeats.containsKey(selectedrowIndex)){
            List<int> temp = bookingSeats[selectedrowIndex]! ;
            temp.addAll(currentRowIndexesFilled);
            bookingSeats[selectedrowIndex] = temp;
          }
          else{
            bookingSeats[selectedrowIndex] = currentRowIndexesFilled;
          }

          bookingGridState.removeAt(selectedrowIndex);
          bookingGridState.insert(selectedrowIndex, currentRow);
        }
        else{
          while(true){
            List<BookingState> currentRow = List.from(bookingGridState[selectedrowIndex]);
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
            if(bookingSeats.containsKey(selectedrowIndex)){
              List<int> temp = bookingSeats[selectedrowIndex]! ;
              temp.addAll(currentRowIndexesFilled);
              bookingSeats[selectedrowIndex] = temp;
            }
            else{
              bookingSeats[selectedrowIndex] = currentRowIndexesFilled;
            }

            bookingGridState.removeAt(selectedrowIndex);
            bookingGridState.insert(selectedrowIndex, currentRow);
            developer.log(TAG , name : "Booking seats " + bookingSeats.toString());
            if(!continueToNextRow){
              break;
            }
            selectedColIndex = 0;
            if(selectedrowIndex == 0){
              selectedrowIndex = 4;
            }
            else{
              selectedrowIndex--;
            }
          }

        }

      }
      else{
        selectedColIndex = 0;
        if(selectedrowIndex == 0){
          selectedrowIndex = 4;
        }
        else{
          selectedrowIndex--;
        }
      }
      currentFamily.seatDetails = SplayTreeMap.from(bookingSeats);
      familyTreeMap[currentFamily.id!] = currentFamily;
      seatBookingGridState = new SeatBooking(bookingGridState);
      //notifyInfo('Added ${currentFamily.totalMembers} tickets');
    }
    catch(e){
      //notifyError('Something went wrong');
    }

    notifyListeners();
  }

  bool addNewStateToSelectedSeats(FamilyModel familyModel, BookingState stateReceived, bool notify){
    try{
      FamilyModel savedFamilyDetails = familyTreeMap[familyModel.id];
      SplayTreeMap<int, List<int>> bookedSeats = new SplayTreeMap<int, List<int>>();
      bookedSeats.addAll(savedFamilyDetails.seatDetails);
      List<List<BookingState>> bookingGridState = seatBookingGridState!.currentBookingState;
      bookedSeats.forEach((key, value) {
        int rowId = key;
        List<int> seatIndexes =  value;
        List<BookingState> currentRow = List.from(bookingGridState[rowId]) ;
        for(int i = 0 ; i< value.length; i++){
          int position = value[i];
          currentRow[position] = stateReceived;
        }
        /*List<int> seatIndexes =  value;
        List<BookingState> currentRow = List.from(bookingGridState[rowId]) ;
        int startAt = seatIndexes.first;
        int endAt = seatIndexes.last;
        List<BookingState> newList = [];
        if(startAt == endAt){
          currentRow.removeAt(startAt);
          currentRow.insert(startAt, stateReceived);
        }
        else if(startAt > endAt){
          for(int i = 0 ; i< value.length; i++){
            int position = value[i];
            currentRow[position] = stateReceived;
          }
        }
        else{
          newList = List.generate(seatIndexes.length, (i) => stateReceived);
          currentRow.removeRange(startAt, endAt);
          currentRow.replaceRange(startAt, endAt, newList);
          developer.log(TAG , name : "$value");
        }*/
        bookingGridState.removeAt(rowId);
        bookingGridState.insert(rowId, currentRow);
      });
      if(stateReceived == BookingState.OCCUPIED || stateReceived == BookingState.AVAILABLE){
        savedFamilyDetails.isbookingDone = false;
        savedFamilyDetails.seatDetails.clear();
      }
      else{
        savedFamilyDetails.isbookingDone = true;
        savedFamilyDetails.seatDetails = SplayTreeMap.from(bookedSeats);
      }
      familyTreeMap[savedFamilyDetails.id!] = savedFamilyDetails;
      seatBookingGridState = new SeatBooking(bookingGridState);
      if(notify){
        notifyListeners();
        //notifyInfo("Updates Applied");
      }

      return true;
    }
    catch(e){
      developer.log(TAG , name: "Exception occurred in changing state $e");
      //notifyError("Update failed");
    }

    return false;
  }

  void createGrid(int x, int y){
    try {
      List<List<BookingState>> prepareBookingGridState = [];
      rows = x;
      columns = y;
      for(int i = 0 ; i < x; i++){
        List<BookingState> inner = [];
        for(int j = 0 ; j < x; j++){
            /*if( i == 4 && (j == 1 || j == 3) ){
              inner.insert(j,BookingState.OCCUPIED);
            }
            else{
              inner.insert(j,BookingState.AVAILABLE);
            }*/
            inner.insert(j,BookingState.AVAILABLE);
        }
        prepareBookingGridState.insert(i, inner);
      }
      developer.log(TAG , name : "Grid was created");
      isGridCreated = true;
      seatBookingGridState = new SeatBooking(prepareBookingGridState);
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
    isSeatsSelected = false;
    if(!familyTreeMap.containsKey(familyId)){
      FamilyModel newFamilyModel = new FamilyModel(id:  familyId, name: familyModel.name, totalMembers: familyModel.totalMembers, memberDetails: List.unmodifiable(familyModel.memberDetails!));
      familyTreeMap[familyId] = newFamilyModel;
      familyTreeMap.forEach((key, value) {
        developer.log(TAG , name:"$key added with ${value}");
      });
      if(!isGridCreated){
        createGrid(gridRows, gridColumns);
      }

      activeFamilyModel = familyModel;
    }
    else{
      throw Exception('$familyId Family Id was already present');
    }

  }

  void resetState(bool isNotify){
    isSeatsSelected = false;
    activeFamilyModel = null;
    if(isNotify){
      notifyListeners();
    }

  }

  void removeFamily(int familyId){
    if(familyTreeMap.containsKey(familyId)){
       familyTreeMap.remove(familyId);
    }
  }

  bool isBookingDone(int familyModelId, bool doNotify){
    if(familyTreeMap.containsKey(familyModelId)){
      FamilyModel familyDetails = familyTreeMap[familyModelId];
      bool isBookingDone = familyDetails.seatDetails.length > 0;
      if(doNotify){
        isSeatsSelected = isBookingDone;
        notifyListeners();
      }

      return isBookingDone;
    }
    else{
      isSeatsSelected = false;
      notifyListeners();
      return false;
    }
  }

  int getCurrentSeatsBooked(){
    int total = 0;
    familyTreeMap.forEach((key, value) {
      FamilyModel currentFamilyModel = value;
      total = total + currentFamilyModel.totalMembers!;
    });
    return total;
  }

}