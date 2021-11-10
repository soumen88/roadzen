import 'dart:collection';
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

  void temp(){
    familyMembers.forEach((element) {
      developer.log(TAG , name : "${element.personFakeName}");
    });

  }

  bool isValidEmail(String email){
    bool isValid = email.contains(new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'));
    return isValid;
  }


}