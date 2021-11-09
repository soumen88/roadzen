import 'package:flutter/material.dart';
import 'dart:developer' as developer;
class HomeScreenBloc extends ChangeNotifier{

  //A = Available -> Green
  //O = Occupied -> Terrain
  //S = Selected -> Grey
  HomeScreenBloc(){
    initGrid();
  }
  String TAG = "HomeScreenBloc";
  List<List<String>> gridState =
  [
    ["", "O", "A", "O", ""],
    ["", "A", "", "", "S"],
    ["", "S", "O", "S", ""],
    ["", "A", "", "", ""],
    ["", "", "O", "A", ""],
  ];




  void initGrid(){
    developer.log(TAG, name: "Init grid");
    notifyListeners();
  }

  void updateGrid(int x , int y){
    developer.log(TAG, name : "Value of $x and $y");
    gridState[x][y] = "P2";
    notifyListeners();
  }


}