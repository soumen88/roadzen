import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadzen/components/BuyButton.dart';
import 'package:roadzen/components/quantitycounter.dart';
import 'dart:developer' as developer;
import '../constants.dart';

class FamilyDetailsScreenPage extends ConsumerWidget {
  FamilyDetailsScreenPage({Key? key}) : super(key: key);

  TextEditingController familyNameController = new TextEditingController();
  String TAG = "FamilyDetailsScreenPage";
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(title: Text("Family Input"),),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  leading: Text("Rs 200", style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  )),
                  trailing: Icon(Icons.favorite_outline),
                ),

                SizedBox(height: 5,),

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
                  color: bodyColor,
                ),

                SizedBox(height: 5,),

                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:40
                    ),
                    child: makeInput("Family Name", false, familyNameController),
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

                Container(
                  margin: EdgeInsets.all(5),
                  child: BuyButton(tap: ()  {
                    developer.log(TAG , name : "Buy button was tapped");

                  },buttonText: "Proceed",),
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget makeInput(String label, bool obsureText, TextEditingController controller ){
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  color: Colors.grey,
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
