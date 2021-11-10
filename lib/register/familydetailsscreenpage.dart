import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadzen/components/NavBar.dart';
import 'package:roadzen/components/buybutton.dart';
import 'package:roadzen/components/quantitycounter.dart';
import 'package:roadzen/models/fakedetails.dart';
import 'package:roadzen/providers/providers.dart';
import 'package:roadzen/routes/AppRouter.gr.dart';
import 'dart:developer' as developer;
import '../constants.dart';

class FamilyDetailsScreenPage extends ConsumerWidget {
  FamilyDetailsScreenPage({Key? key}) : super(key: key);
  FakeDetails? fakeDetails;
  TextEditingController familyNameController = new TextEditingController();
  String TAG = "FamilyDetailsScreenPage";
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    fakeDetails = watch(fakeDetailsProvider).fakeDetails;
    return Scaffold(
      appBar: NavBar(
        isCartRouteAllowed: true,
        screenName: "Family Input",
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Container(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Hero(
                      tag: 1,
                      child: Image.asset(
                        "assets/mrbean.jpg",
                        height: MediaQuery.of(context).size.height * 0.4,
                        fit: BoxFit.fitHeight,
                        width: MediaQuery.of(context).size.width,
                      ),

                    ),
                  ),
                  color: kRoadZenColor,
                ),

                Text("Per Ticket: Rs 200", style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                )),

                SizedBox(height: 5,),

                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:40
                    ),
                    child: makeInput(context, "Family Name", false, familyNameController),
                ),

                SizedBox(height: 5,),

                Text("Select Total Members"),

                SizedBox(height: 5,),

                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: QuantityCounter(
                    incrementCountSelected: (count) {
                      developer.log(TAG , name :"increment Count was selected.");

                    },
                    decrementCountSelected: (count){
                      developer.log(TAG , name :"decrement Count was selected.");

                    },
                    initialCount: 1,
                  ),
                ),
              ],
            ),
          )
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(5),
        child: BuyButton(tap: ()  {
          developer.log(TAG , name : "Buy button was tapped");
          context.router.navigate(FamilyRegistrationScreenRoute());
        },buttonText: "Proceed",),
      ),
    );
  }

  Widget makeInput(BuildContext context, String label, bool obsureText, TextEditingController controller ){

    final yourText = fakeDetails!.personFakeLastName!;
    controller.value = controller.value.copyWith(
      text: controller.text + yourText,
      selection: TextSelection.collapsed(offset: controller.value.selection.baseOffset + yourText.length,),
    );

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style:TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black87
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 5,),

          TextField(
            obscureText: obsureText,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: kRoadZenColorUp,
                ),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)
              ),
            ),
          ),

          SizedBox(height: 30,),

        ],
      ),
    );
  }
}
