import 'dart:collection';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadzen/models/familymodel.dart';

class FamilyRegistrationBloc extends StateNotifier<AsyncData<SplayTreeMap<int, List<FamilyModel>>?>>{

  FamilyRegistrationBloc() : super(AsyncData(null));

  int familyIdCounter = 0;

  void registerFamily(String name, int totalMembers){
      familyIdCounter++;
  }

  bool isValidEmail(String email){
    bool isValid = email.contains(new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'));
    return isValid;
  }

}