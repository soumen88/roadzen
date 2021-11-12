import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadzen/models/FakeDetails.dart';
import 'package:roadzen/models/familymodel.dart';
import 'dart:developer' as developer;

class FamilyRegistrationBloc extends ChangeNotifier{

  int familyIdCounter = 0;
  String familyName = "";
  int totalMembersInFamily = 0;
  int counter = 1;
  List<FakeDetails> familyMembers = [];
  List<FamilyModel> familiesList = [];
  String TAG = "FamilyRegistrationBloc";
  FamilyModel currentFamilyModel = new FamilyModel();

  void registerFamily(String name, int totalMembers){
      familyName = name;
      totalMembersInFamily = totalMembers;
      notifyListeners();
  }

  void incrementFamilyIdCounter(){
    familyIdCounter = familyIdCounter + 1;
    developer.log(TAG, name : "Family id counter $familyIdCounter");
  }

  void temp(){
    developer.log(TAG, name : "Family id current counter $familyIdCounter");
  }

  void incrementCounter(){
    counter++;
    notifyListeners();
  }

  void registerFamilyMember(String familyMemberName, String familyMemberAge){
    try{
      List<String> splittedName = familyMemberName.split(" ");
      String firstName = splittedName.first;
      String lastName = splittedName.last;
      FakeDetails fakeDetails = new FakeDetails(personFakeName:  familyMemberName,personFakeFirstName:  firstName,personFakeLastName:  lastName,personFakeAge:  int.parse(familyMemberAge));
      familyMembers.add(fakeDetails);
    }
    catch(e){
      developer.log(TAG,  name :  "Exception $e");
      FakeDetails fakeDetails = new FakeDetails(personFakeName:  familyMemberName,personFakeFirstName:  familyMemberName,personFakeLastName:  familyMemberName,personFakeAge:  int.parse(familyMemberAge));
      familyMembers.add(fakeDetails);
    }
  }

  void addNewFamilyMember(){
    currentFamilyModel = new FamilyModel(id: familyIdCounter, totalMembers: totalMembersInFamily, name: familyName, icon: Icons.timer.toString(), memberDetails: familyMembers );
    familiesList.add(currentFamilyModel);
    notifyListeners();
  }

  bool isValidEmail(String email){
    bool isValid = email.contains(new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'));
    return isValid;
  }

  void reset(){
    familyName = "";
    totalMembersInFamily = 0;
    counter = 1;
    familyMembers.clear();
    notifyListeners();
  }

}