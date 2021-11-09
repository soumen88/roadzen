import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadzen/booking/bookingstate.dart';
import 'package:roadzen/bottombar/bottomstatusbar.dart';
import 'package:roadzen/components/filterbutton.dart';
import 'package:roadzen/constants.dart';
import 'package:roadzen/homescreen/categories.dart';
import 'package:roadzen/models/family.dart';
import 'package:roadzen/providers/providers.dart';

class HomeScreenPage extends ConsumerWidget {
  String TAG = "HomeScreen";
  var currentFamily =  familyList[3];
  HomeScreenPage({Key? key}) : super(key: key);
  List<List<BookingState>> gridState = [];

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentGridState = watch(homeScreenProvider).bookingGridState;
    return Scaffold(
      appBar: AppBar(title: Text("HomeScreen"),),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(kDefaultPadding),
        child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ElevatedButton(
                  onPressed: (){
                    developer.log(TAG , name : "Current family id ${currentFamily.id}");
                    context.read(homeScreenProvider.notifier).test();
                  },
                  child: Text("Test"),
                ),
                Row(
                    children: [

                      FilterButton(
                        tap: () {},
                      ),

                      Expanded(child: Categories(
                        familyCallback: (data){
                          currentFamily = data!;
                          developer.log(TAG , name : "Current family selected ${data.id!}");
                        },
                      ))

                    ]
                ),

                SizedBox(height: kDefaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: [
                        Icon(
                          Icons.terrain,
                          size: 25.0,
                          color: Colors.red,
                        ),
                        Text("Occupied")
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          width: 15,
                          height: 15,
                          color: Colors.grey,
                        ),
                        Text("Selected")
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          width: 15,
                          height: 15,
                          color: Colors.green,
                        ),
                        Text("Available")
                      ],
                    ),


                  ],
                ),
                Consumer(
                    builder : (builder, watch, child){
                      gridState = List.from(currentGridState);
                      if(gridState.isNotEmpty){
                        return _buildGameBody(currentGridState);
                      }
                      else{
                        return Text("Loading...");
                      }
                    }
                )
              ],
            )
        ),
      ),
      bottomNavigationBar: Consumer(
        builder: (builder, watch, child){
          final provider = watch(bottomBarStatusProvider).currentStatus;
          return Visibility(
              child: BottomStatusBar(
                animationStarted: () {  },
                animationFinished: (data){

                },
              ),
              visible: provider,

          );
        },
      ),
    );
  }

  Widget _buildGameBody(List<List<BookingState>> gridState) {
    int gridStateLength = gridState.length;
    return Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0)
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridStateLength,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => _buildGridItems(context, index, gridStateLength),
                itemCount: gridStateLength * gridStateLength,
              ),
            ),
          ),
        ]);
  }

  Widget _buildGridItems(BuildContext context, int index, int gridStateLength) {
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    return GestureDetector(
      onTap: () {
          var currentState = getCurrentBookingState(x, y);
          developer.log(TAG , name : "Current State ${currentState.toString()}");
          context.read(homeScreenProvider.notifier).updateGrid(x,y, currentFamily);
          context.read(bottomBarStatusProvider.notifier).statusListener("Added ${currentFamily.totalMembers} tickets", false);
      },
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5)
          ),
          child: Center(
            child: _buildGridItem(x, y),
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(int x, int y) {
    switch (gridState[x][y]) {
      case BookingState.AVAILABLE:
        return Container(
          color: Colors.green,
        );
        break;
      case BookingState.SELECTED:
        return Container(
          color: Colors.grey,
          child: Text(gridState[x][y].toString()),
        );
        break;
      case BookingState.OCCUPIED:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.terrain,
              size: 25.0,
              color: Colors.red,
            ),
            Text(currentFamily.id.toString())
          ],
        );
        break;
      /*case 'O':
        return Icon(Icons.remove_red_eye, size: 40.0);
        break;*/
      default:
        return Text(gridState[x][y].toString());
    }
  }

  BookingState getCurrentBookingState(int x, int y){
    return gridState[x][y];
  }
}
