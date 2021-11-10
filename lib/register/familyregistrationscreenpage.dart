import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadzen/components/buybutton.dart';
import 'package:roadzen/models/fakedetails.dart';
import 'dart:developer' as developer;

import 'package:roadzen/providers/providers.dart';

class FamilyRegistrationScreenPage extends ConsumerWidget {
  FamilyRegistrationScreenPage({Key? key}) : super(key: key);
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  FakeDetails? fakeDetails;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final autheticate = watch(registrationProvider);
    fakeDetails = watch(fakeDetailsProvider).fakeDetails;
    return GestureDetector(
      onTap: (){
        developer.log("LoginScreenPage", name: "Tap deetected");
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
                Container(
                  child: autheticate.when(
                      data: (data) {
                        return loadScreenUi(context);
                      },
                      loading: () {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Center(child: CircularProgressIndicator())
                        );
                      },
                      error: (e, st) =>  Text("Something went wrong")
                  ),
                ),
                //_buildBody(),
              ],
            ),
          ),
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
            Text("Kindly fill in below details",style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
            ),),
            SizedBox(height: 30,)
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            padding: EdgeInsets.only(top: 3,left: 3),
            child: BuyButton(tap: ()  {
              validate(context);

            },buttonText: "Login",),
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
    String currentScreen = "LoginScreenPage";
    String emailEntered = nameController.text.toString();
    String passwordEntered = ageController.text.toString();
    bool isEmailValid = context.read(registrationProvider.notifier).isValidEmail(emailEntered);
    if(!isEmailValid){
      displaySnackBar(context, "Invalid Name", true);
      return false;
    }
    context.read(fakeDetailsProvider).generateFakeDetails();

    return true;
  }

  void displaySnackBar(BuildContext context, String message, bool isError){
    var snackBar = SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void startProductListingScreen(BuildContext context) async{


    //context.router.replace(ProductsListingScreenRoute());

  }

  Widget makeInput(BuildContext context, String label, bool obsureText, TextEditingController controller ){

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
