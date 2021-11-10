import 'dart:collection';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadzen/models/familymodel.dart';

class FamilyRegistrationBloc extends StateNotifier<AsyncData<SplayTreeMap<int, List<FamilyModel>>?>>{

  FamilyRegistrationBloc() : super(AsyncData(null));

  int familyIdCounter = 0;

  void registerFamily(String name, int totalMembers){
      familyIdCounter++;
  }
}