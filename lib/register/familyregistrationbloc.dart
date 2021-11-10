import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadzen/models/FakeDetails.dart';
import 'package:roadzen/models/familymodel.dart';
import 'dart:developer' as developer;

class FamilyRegistrationBloc extends StateNotifier<AsyncData<SplayTreeMap<int, List<FamilyModel>>?>>{

  FamilyRegistrationBloc() : super(AsyncData(null));

  int familyIdCounter = 0;
  String familyName = "";
  int totalMembersInFamily = 0;
  int counter = 1;
  List<FakeDetails> familyMembers = [];
  String TAG = "FamilyRegistrationBloc";
  SplayTreeMap<int, FamilyModel> currentMembers = new SplayTreeMap();

  void registerFamily(String name, int totalMembers){
      familyName = name;
      totalMembersInFamily = totalMembers;
  }

  void incrementFamilyIdCounter(){
    familyIdCounter++;
  }
  void incrementCounter(){
    counter++;
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
    FamilyModel familyModel = new FamilyModel(id: familyIdCounter, totalMembers: totalMembersInFamily, name: familyName, icon: Icons.timer.toString(), memberDetails: familyMembers );
    familyMembers.forEach((element) {
      developer.log(TAG , name : "${element.personFakeName}");
    });
    currentMembers[familyIdCounter] = familyModel;
  }

  bool isValidEmail(String email){
    bool isValid = email.contains(new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'));
    return isValid;
  }


}