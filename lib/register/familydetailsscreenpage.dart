import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadzen/bottombar/bottomstatusbar.dart';
import 'package:roadzen/components/NavBar.dart';
import 'package:roadzen/components/buybutton.dart';
import 'package:roadzen/components/quantitycounter.dart';
import 'package:roadzen/models/fakedetails.dart';
import 'package:roadzen/providers/providers.dart';
import 'package:roadzen/routes/AppRouter.gr.dart';
import 'dart:developer' as developer;
import '../constants.dart';


class FamilyDetailsScreenPage extends StatefulWidget{
  FamilyDetailsScreenPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FamilyDetailsScreenState();
  }

}

class FamilyDetailsScreenState extends State<FamilyDetailsScreenPage> {

  FakeDetails? fakeDetails;
  TextEditingController familyNameController = new TextEditingController();
  String TAG = "FamilyDetailsScreenPage";
  int memberCounter = 0;
  int currentBookingStatus = 0;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read(fakeDetailsProvider).generateFakeDetails();
    });

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        dismissKeyboard(context);
      },
      onTapDown: (details){
        dismissKeyboard(context);
      },
      onTapUp: (details){
        dismissKeyboard(context);
      },
      child: Scaffold(
        appBar: NavBar(
          isCartRouteAllowed: true,
          screenName: "Family Input",
        ),
        body: SafeArea(
            child: SingleChildScrollView(
              child: Consumer(
                builder: (builder , watch , child){
                  fakeDetails = watch(fakeDetailsProvider).fakeDetails;
                  currentBookingStatus = 25 - context.read(homeScreenProvider.notifier).getCurrentSeatsBooked();
                  memberCounter = watch(counterProvider).count;
                  if(fakeDetails != null){
                    return loadScreenUi();
                  }
                  else{
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Center(child: CircularProgressIndicator())
                    );
                  }
                },
              ),
            )
        ),
        bottomNavigationBar: Consumer(
          builder: (builder, watch, child){
            final provider = watch(bottomBarStatusProvider).isStatusBarDisplayed;
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
                  validate();
                },buttonText: "Proceed",)
              ],
            );
          },
        ),
      ),
    );
  }

  Widget loadScreenUi(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Per Ticket: Rs 200", style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                )),
                SizedBox(height: 5,),
                Hero(
                  tag: 1,
                  child: Image.asset(
                    "assets/mrbean.jpg",
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.fitHeight,
                    width: MediaQuery.of(context).size.width,
                  ),
                )
              ],
            ),
          ),
          color: kRoadZenColor,
        ),



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
              memberCounter++;
            },
            decrementCountSelected: (count){
              memberCounter--;
            },
            initialCount: memberCounter,
          ),
        ),
        SizedBox(height: 5,),
        Text("Available Tickets : ${currentBookingStatus}"),
      ],
    );
  }

  Widget makeInput(BuildContext context, String label, bool obsureText, TextEditingController controller ){

    final yourText = fakeDetails!.personFakeLastName!;
    controller.text = "";
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

  void validate(){
    int currentBookingStatus =  context.read(homeScreenProvider.notifier).getCurrentSeatsBooked();
    int total = memberCounter + currentBookingStatus;
    if(total >= 26){
      displaySnackBar(context, "Cannot Accomodate this family", true);
      return;
    }
    if(memberCounter == 0){
      displaySnackBar(context, "Add Family members", true);
      return;
    }
    String familyName = familyNameController.text.toString();
    if(familyName.isEmpty){
      displaySnackBar(context, "Family name is empty", true);
      return;
    }
    context.read(registrationProvider.notifier).incrementFamilyIdCounter();
    context.read(registrationProvider.notifier).registerFamily(familyName, memberCounter);
    context.router.navigate(FamilyRegistrationScreenRoute());
  }

  void displaySnackBar(BuildContext context, String message, bool isError){
    var snackBar = SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void dismissKeyboard(BuildContext context){
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

}
