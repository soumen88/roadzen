import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expandable/expandable.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:roadzen/components/navbar.dart';
import 'package:roadzen/models/familymodel.dart';
import 'package:roadzen/providers/providers.dart';
import 'dart:developer' as developer;
import '../constants.dart';
class FamilyListingScreenPage extends ConsumerWidget {
  FamilyListingScreenPage({Key? key}) : super(key: key);
  String TAG = "FamilyListingScreenPage";
  List<FamilyModel> familyListDisplayed = [];
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final familyList = watch(homeScreenProvider).familyTreeMap;
    if(familyList != null && familyList.isNotEmpty){

      familyList.forEach((key, value) {
        familyListDisplayed.add(value);
      });
    }
    return Scaffold(
      appBar: NavBar(
        isCartRouteAllowed: false,
        screenName: "All Family Details",
      ),
      body: Consumer(
        builder : (builder, watch, child){
          if(familyList.isNotEmpty){
            return ExpandableTheme(
              data: const ExpandableThemeData(
                iconColor: Colors.blue,
                useInkWell: true,
              ),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index){
                  FamilyModel current = familyListDisplayed[index];
                  developer.log(TAG , name : "Family name ${current.name}");
                  return FamilyCard(current, index);
                  //return Text("Body here");
                },
                itemCount: familyList.length,
                shrinkWrap: true,
              ),
            );
          }
          else{
            return Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: kRoadZenColor ,
              alignment: Alignment.center,
              child: Container(
                width: 300,
                height: 300,
                child: Column(
                  children: [
                    Image.asset('assets/no_results.png'),
                    Text("Sorry, No Result Found" , style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),)
                  ],
                ),
              ),
            );
          }

        }
      ),
    );
  }
}
const loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

class FamilyCard extends StatelessWidget {

  FamilyModel? currentFamilyModel;
  String TAG = "FamilyListingScreenPage";
  var iconsArr = ["family_and_kids_two.png", "family_and_kids.png"];
  int index;

  FamilyCard(this.currentFamilyModel, this.index);

  @override
  Widget build(BuildContext context) {
    int position = index % 2;
    developer.log(TAG , name: "Random position $position");
    String iconPath = "assets/" + iconsArr[position];
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: (){
                    developer.log(TAG , name : "Favorite icon clicked");
                    displayPopUp(context);
                  },
                  child: ListTile(
                    title: Text(currentFamilyModel!.name!,
                        style: TextStyle(
                          fontSize: 22.0,
                        )),

                    trailing: Icon(Icons.favorite_outline),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: Container(
                    decoration: BoxDecoration(
                      color: kRoadZenColor ,
                      shape: BoxShape.rectangle,
                    ),
                    child: Image.asset(
                      "$iconPath",
                      height: MediaQuery.of(context).size.height * 0.4,
                      fit: BoxFit.fitHeight,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Movie Show: Mr.Bean",
                        )
                    ),
                    collapsed: Text(
                      "Click To See Details",
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        for (var data in currentFamilyModel!.memberDetails!)
                          Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${data.personFakeName!} (${data.personFakeAge})",
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                  )
                                ],
                              )
                          ),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }


  void displayPopUp(BuildContext context){
    Alert(
      context: context,
      type: AlertType.info,
      title: "Roadzen",
      desc: "Do you want to book Special seats for this family?",
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: ()  {
            Navigator.pop(context);

          },
          width: 120,
        )
      ],
    ).show();
  }
}
