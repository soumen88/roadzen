import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadzen/booking/bookingstate.dart';
import 'package:roadzen/bottombar/bottomstatusbar.dart';
import 'package:roadzen/components/buybutton.dart';
import 'package:roadzen/components/filterbutton.dart';
import 'package:roadzen/components/navbar.dart';
import 'package:roadzen/constants.dart';
import 'package:roadzen/homescreen/categories.dart';
import 'package:roadzen/listeners/message_listener.dart';
import 'package:roadzen/mixin/message_notifier_mixin.dart';
import 'package:roadzen/models/familymodel.dart';
import 'package:roadzen/providers/providers.dart';
import 'package:roadzen/mixin/message_notifier_mixin.dart';
import 'package:tuple/tuple.dart';
import 'package:roadzen/routes/AppRouter.gr.dart';

class HomeScreenPage extends StatefulWidget{
  HomeScreenPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenPageState();
  }

}

class HomeScreenPageState extends State<HomeScreenPage> {
  String TAG = "HomeScreen";
  FamilyModel? currentFamily;

  List<List<BookingState>> gridState = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Consumer(
        builder : (builder, watch, child){
          final currentState = watch(homeScreenProvider).seatBookingGridState;
          final message = watch(homeScreenProvider.notifier).info;
          final isError = watch(homeScreenProvider.notifier).isError;
          bool isState = context.read(homeScreenProvider.notifier).isStateUpdated;

          if(currentState != null){
            gridState.clear();
            gridState = List.from(currentState.currentBookingState);
            developer.log(TAG , name: "Grid size "+ gridState.length.toString());
            currentFamily = context.read(homeScreenProvider.notifier).activeFamilyModel;
          }

          if(isState){
            context.router.navigate(CheckOutScreenRoute());
          }
          if(message != null && message.isNotEmpty){
            context.read(bottomBarStatusProvider.notifier).statusListener(message, isError);
          }
          return Scaffold(
            appBar: NavBar(
              isCartRouteAllowed: true,
              screenName: "Book Seats",
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Center(
                child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        ElevatedButton(
                          onPressed: (){
                            developer.log(TAG , name : "Current family id ${currentFamily!.id}");
                            //context.read(homeScreenProvider.notifier).markOccupiedSeats();
                            context.read(registrationProvider.notifier).temp();
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
                        /*Text("Select ${currentFamily!.totalMembers} tickets for ${currentFamily!.name} family",
                    style: TextStyle(
                        fontSize: 24
                    ),
                  ),
                  */
                        Consumer(
                            builder : (builder, watch, child){
                              if(gridState.isNotEmpty){
                                return _buildGameBody(gridState);
                              }
                              else{
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: Center(child: CircularProgressIndicator())
                                );
                              }
                            }
                        ),

                        Container(
                            width: MediaQuery.of(context).size.width,

                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(50),
                              child: Image.asset("assets/screen.png"),
                            )
                        ),

                      ],
                    )
                ),
              ),
            ),
            bottomNavigationBar: Consumer(
              builder: (builder, watch, child){
                final provider = watch(bottomBarStatusProvider).currentStatus;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                      child:BottomStatusBar(
                        animationStarted: () {  },
                        animationFinished: (data){

                        },
                      ),
                      visible: provider,
                    ),

                    BuyButton(tap: ()  {
                      validate(context);
                    },buttonText: "Pay Now",)
                  ],
                );
              },
            ),
          );
        }
    ),
        onWillPop: _onWillPop
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
          final map = context.read(homeScreenProvider.notifier).familyTreeMap;
          BookingState bookingState = getCurrentBookingState(x,y);
          switch(bookingState){
            case BookingState.AVAILABLE:{
              context.read(homeScreenProvider.notifier).updateGrid(x,y, currentFamily!);
            }
            break;
            case BookingState.OCCUPIED:{
              context.read(homeScreenProvider.notifier).addNewStateToSelectedSeats(currentFamily!, BookingState.AVAILABLE);
            }
            break;
            case BookingState.SELECTED:{
              context.read(bottomBarStatusProvider.notifier).statusListener("Seat Already Occupied", true);
            }
            break;
          }
          if(!map.containsKey(currentFamily!.id!)){

          }
          else{

          }

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
          //child: Text(gridState[x][y].toString()),
        );
        break;
      case BookingState.OCCUPIED:
        developer.log(TAG , name : "Tapped on occupied $x and $y");
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.terrain,
              size: 25.0,
              color: Colors.red,
            ),
            //Text(currentFamily!.id.toString())
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

  void validate(BuildContext context){

    bool isDone =  context.read(homeScreenProvider.notifier).isBookingDone(currentFamily!.id!);
    if(isDone){
      context.read(homeScreenProvider.notifier).addNewStateToSelectedSeats(currentFamily!, BookingState.SELECTED);

    }
    else{
      context.read(bottomBarStatusProvider.notifier).statusListener("Kindly Select Seats", true);
    }
  }

  Future<bool> _onWillPop()  async {
    developer.log(TAG, name: "Back button pressed");
    context.read(registrationProvider.notifier).reset();
    return Future.value(true);

  }
}
