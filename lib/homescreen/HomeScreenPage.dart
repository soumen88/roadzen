import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadzen/components/FilterButton.dart';
import 'package:roadzen/constants.dart';
import 'package:roadzen/homescreen/Categories.dart';
import 'package:roadzen/providers/Providers.dart';

class HomeScreenPage extends ConsumerWidget {
  String currentScreen = "HomeScreen";

  HomeScreenPage({Key? key}) : super(key: key);
  List<List<String>> gridState =
 [
    ];
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentGridState = watch(homeScreenProvider).gridState;
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

                  },
                  child: Text("Test"),
                ),
                Row(
                    children: [

                      FilterButton(
                        tap: () {},
                      ),

                      Expanded(child: Categories())

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
                      return _buildGameBody(currentGridState);
                    }
                )
              ],
            )
        ),
      ),
    );
  }

  Widget _buildGameBody(List<List<String>> gridState) {
    int gridStateLength = gridState.length;
    return Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
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
          context.read(homeScreenProvider.notifier).updateGrid(0, 0);
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
      case '':
        return Text('');
        break;
      case 'A':
        return Container(
          color: Colors.green,
        );
        break;
      case 'S':
        return Container(
          color: Colors.grey,
        );
        break;
      case 'O':
        return Icon(
          Icons.terrain,
          size: 25.0,
          color: Colors.red,
        );
        break;
      case 'O':
        return Icon(Icons.remove_red_eye, size: 40.0);
        break;
      default:
        return Text(gridState[x][y].toString());
    }
  }
}
