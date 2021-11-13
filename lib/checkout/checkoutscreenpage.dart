import 'dart:async';

import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as developer;

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:roadzen/bottombar/bottomstatusbar.dart';
import 'package:roadzen/components/buybutton.dart';
import 'package:roadzen/components/navbar.dart';
import 'package:roadzen/constants.dart';
import 'package:roadzen/models/fakedetails.dart';
import 'package:roadzen/providers/providers.dart';

class CheckOutScreenPage extends ConsumerWidget {
  String currentScreen = "CheckOutScreenPage";
  int total = 0;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentFamilyModel = watch(homeScreenProvider).activeFamilyModel;
    if(currentFamilyModel != null){
      final totalMembers = watch(homeScreenProvider).activeFamilyModel!.totalMembers;
      total = 200 * totalMembers!;
    }


    return Scaffold(
      appBar: NavBar(
        isCartRouteAllowed: true,
        screenName: "Customer Checkout",
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex:5,
              child:Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kRoadZenColor,kRoadZenColorUp],
                  ),
                ),
                child: Column(
                    children: [
                      SizedBox(height: 110.0,),
                      CircleAvatar(radius: (52),
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius:BorderRadius.circular(50),
                            child: Image.asset("assets/rz_logo.jpg"),
                          )
                      ),
                      SizedBox(height: 10.0,),
                      Text('Roadzen',
                          style: TextStyle(
                            color:Colors.white,
                            fontSize: 20.0,
                          )),
                      SizedBox(height: 10.0,),
                    ]
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Card(
                  child: Padding(
                    padding:EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            child:Column(
                              children: [
                                Text('Order id',
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14.0
                                  ),),
                                SizedBox(height: 5.0,),
                                Text("88",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),)
                              ],
                            )
                        ),

                        Container(
                          child: Column(
                              children: [
                                Text('Movie Date',
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14.0
                                  ),),
                                SizedBox(height: 5.0,),
                                Text('November 15th',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),)
                              ]),
                        ),

                        Container(
                            child:Column(
                              children: [
                                Text('Screen Number',
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14.0
                                  ),),
                                SizedBox(height: 5.0,),
                                Text('3',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),)
                              ],
                            )
                        ),
                      ],
                    ),
                  )
              ),
            ),
            Flexible(
              flex: 2,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text("Total Bill",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: kDefaultPadding,),
                      Consumer(
                          builder: (builder, watch , child){
                            return Text("Price : Rs. " +total.toString(), style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold
                            ));
                          }
                      )
                    ],
                  ),
                ),
              ),
            ),
            Consumer(
              builder: ( context, watch, child) {
                  final cartResponse = watch(registrationProvider);
                  return Container(

                  );
              },
            ),
            Flexible(
              flex:2,
              child: Container(
                color: Colors.grey[200],
                child: Center(
                    child:Card(
                      //margin: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                      child: Consumer(
                          builder: (builder, watch , child){
                            return Container(
                              //child :_buildCheckOutList(savedProducts),
                            );
                          }
                      ),
                    )
                ),
              ),
            ),
          ],
        ),

      ),
      bottomNavigationBar: BuyButton(tap: ()  {
        reset(context);
        context.router.popUntilRoot();
      },buttonText: "Continue With Next Family"),
    );
  }

  Widget _buildCheckOutList(List<FakeDetails> familyMembersList){
    return ListView.builder(

        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: familyMembersList.length,
        itemBuilder: (context, index){
            FakeDetails savedDetails = familyMembersList[index];
            return Card(
              elevation: 4.0,
              child: ListTile(
                title: Text(savedDetails.personFakeName!),
                //subtitle:getRow(savedProducts),
              ),
            );
        }
    );
  }

  Widget getRow(FakeDetails savedProducts){
    //double totalCost = savedProducts.product.price! * savedProducts.count!;
    double totalCost = 10;
    return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 10.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Quantity",
              style: TextStyle(
                fontSize: 15.0,
              ),),
            Text("Some Content here",
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[400],
              ),)
          ],
        ),
        SizedBox(width: 20.0,),
        //Text("Price: ${savedProducts.count} x ${savedProducts.product.price!} = ${totalCost.round()}"),
        SizedBox(height: 10),
      ],
    );
  }

  void reset(BuildContext context){
    context.read(fakeDetailsProvider).generateFakeDetails();
    context.read(counterProvider.notifier).reset();
    context.read(registrationProvider.notifier).reset();
    context.read(homeScreenProvider.notifier).resetState(true);

  }
}

