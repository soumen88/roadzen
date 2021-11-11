import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadzen/bottombar/bottomstatusbar.dart';
import 'package:roadzen/components/buybutton.dart';
import 'package:roadzen/homescreen/homescreenpage.dart';
import 'package:roadzen/models/fakedetails.dart';
import 'dart:developer' as developer;

import 'package:roadzen/providers/providers.dart';
import 'package:roadzen/routes/AppRouter.gr.dart';

class FamilyRegistrationScreenPage extends ConsumerWidget {
  FamilyRegistrationScreenPage({Key? key}) : super(key: key);
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  FakeDetails? fakeDetails;
  int currentMemberNumber = 0;
  bool isLast = false;
  String TAG = "FamilyRegistrationScreenPage";
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final autheticate = watch(registrationProvider);
    fakeDetails = watch(fakeDetailsProvider).fakeDetails;
    currentMemberNumber = context.read(registrationProvider.notifier).counter;
    isLast = currentMemberNumber == context.read(registrationProvider.notifier).totalMembersInFamily;
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Login Page"),),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Consumer Widget
                loadScreenUi(context),
                //_buildBody(),
              ],
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
                  bool isCorrect = validate(context);
                  if(isLast && isCorrect){
                    startBookingScreen(context);
                  }
                },buttonText: isLast ? "Book Seats" : "Add Member",)
              ],
            );
          },
        ),
      ),
    );
  }

  void dismissKeyboard(BuildContext context){
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Widget loadScreenUi(BuildContext context){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            Text ("Register a Member", style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 20,),
            Text("Kindly fill in below details for member",style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
            ),),
            SizedBox(height: 30,),
            Text("${currentMemberNumber}",style: TextStyle(
              fontSize: 35,
              color: Colors.grey[700],
            ),),
            SizedBox(height: 30,),


          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 40
          ),
          child: Column(
            children: [
              makeInput(context, "Name", false, nameController),
              makeInput(context, "Age",false, ageController),
            ],
          ),
        ),

        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Dont have an account?"),
            Padding(
              padding: EdgeInsets.all(10),
              child: InkWell(
                onTap: (){
                  //context.router.navigate(RegistrationScreenRoute());
                },
                child: Text("Sign Up",style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18
                ),),
              ),
            ),

          ],
        ),


      ],
    );
  }

  bool validate(BuildContext context){
    String nameEntered = nameController.text.toString();
    String age = ageController.text.toString();

    if(nameEntered.isEmpty){
      context.read(bottomBarStatusProvider.notifier).statusListener("Name is empty", true);
      return false;
    }
    if(age.isEmpty){
      context.read(bottomBarStatusProvider.notifier).statusListener("Age is empty", true);
      return false;
    }
    if(!isLast){
      context.read(registrationProvider.notifier).incrementCounter();
      context.read(registrationProvider.notifier).registerFamilyMember(nameEntered, age);
      context.read(fakeDetailsProvider).generateFakeDetails();
    }

    return true;
  }




  void startBookingScreen(BuildContext context) async{
    context.read(registrationProvider.notifier).addNewFamilyMember();
    context.router.navigate(HomeScreenRoute());

  }

  Widget makeInput(BuildContext context, String label, bool obsureText, TextEditingController controller ){
    controller.text = "";
    if(label == "Name"){
      final yourText = fakeDetails!.personFakeName!;
      controller.value = controller.value.copyWith(
        text: controller.text + yourText,
        selection: TextSelection.collapsed(offset: controller.value.selection.baseOffset + yourText.length,),
      );
    }
    else{
      final yourText = fakeDetails!.personFakeAge!.toString();
      controller.value = controller.value.copyWith(
        text: controller.text + yourText,
        selection: TextSelection.collapsed(offset: controller.value.selection.baseOffset + yourText.length,),
      );
    }


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,style:TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87
        ),),
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
        SizedBox(height: 30,)

      ],
    );
  }

}
